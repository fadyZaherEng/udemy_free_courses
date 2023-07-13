import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CourseView extends StatefulWidget {
  final String courseUrl;

  CourseView({required this.courseUrl});

  @override
  State<StatefulWidget> createState() {
    return _CourseViewState();
  }
}

class _CourseViewState extends State<CourseView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    _loadHtmlFromAssets();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    //String fileHtmlContents = await rootBundle.loadString(filePath);
    //_controller.loadRequest(Uri.dataFromString(fileHtmlContents,
    //  mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
    _controller.loadRequest(Uri.parse(
      widget.courseUrl,
    ));
  }
}
