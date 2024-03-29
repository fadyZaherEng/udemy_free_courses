import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_free_courses/layout/home/home_screen.dart';
import 'package:udemy_free_courses/shared/components/components.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/intro.svg", height: 324, width: 324,),
            SizedBox(height: 36,),
            Text("Find Your Favouet Course", style: GoogleFonts.poppins(
              fontSize: 24, color: Color(0xff232323),),),
            Padding(
              padding: const EdgeInsets.only(top: 9, bottom: 129),
              child: Text(
                "Lorem ipsum dolor sit amet, consetetur\n sadipscing elitr, sed diam nonumy eirmod\n tempor invidunt ut labore et dolore",
                style: GoogleFonts.poppins(
                    color: Color(0xffBBBBBB), fontSize: 14),),
            ),
            GestureDetector(
              onTap: () {
                navigateToWithoutReturn(context, HomeScreen());
              },
              child: Container(
                width: 315,
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0xff6CC4EE),

                  borderRadius: BorderRadius.circular(34),
                ),
                child: Center(child: Text("Get Started",
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Colors.white),)),
              ),
            )

          ],

        ),
      ),

    );
  }
}
