
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:udemy_free_courses/layout/home/courseItem.dart';
import 'package:udemy_free_courses/models/course_model.dart';
import 'package:udemy_free_courses/shared/components/constants.dart';
import 'package:udemy_free_courses/shared/network/remote/dio_helper.dart';


class Category extends StatefulWidget {
  final String category;
  Category({required this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  bool _loading = true;
  List<CourseModel> courses = [];

  Future<void> getCat(String cat) async {
    DioHelper.getData(url: Cat_URL).then((value) {
      value.data.forEach((element) {
        CourseModel courseModel = CourseModel(
          heading: element['title'],
          image: element['image'],
          courseLink: element['link'],
          successRate: '',
        );
        courses.add(courseModel);
      });
    }).catchError((onError) {
      print(onError.toString());
    });
  }


  getCategoryCourse() async {
  getCat(widget.category);
    setState((){
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:   _loading ? Center(
        child: SafeArea(
          child: Container(
            child: SpinKitWave(
              color: Color(0xff99CAE1),
              size: 30.0,
            ),
          ),
        ),
        ////categories
      ) : SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CourseTile(
                  imageURL: courses[index].image,
                  title: courses[index].heading,
                  courseURL: courses[index].courseLink,
                  successRate: courses[index].successRate,

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
