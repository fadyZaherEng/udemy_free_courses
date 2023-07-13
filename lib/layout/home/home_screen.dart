import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_free_courses/layout/home/cat_item.dart';
import 'package:udemy_free_courses/layout/home/courseItem.dart';
import 'package:udemy_free_courses/layout/home/cubit/cubit.dart';
import 'package:udemy_free_courses/layout/home/cubit/states.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UdemyCubit>(
      create: (ctx)=>UdemyCubit()..getCategories()..getCourse(),
      child: BlocConsumer<UdemyCubit,UdemyAppSates>(
        listener: (context,state){},
        builder: (ctx,state){
          return Scaffold(
            backgroundColor: Color(0xffFFFFFF),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xffFFFFFF),
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: Color(0XFF747474),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Find your Free Courses",
                            style: GoogleFonts.notoSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff232323)),
                          ),
                        ],
                      ),
                      SvgPicture.asset("assets/images/love.svg",color: Color(0xff99CAE1),),
                    ],
                  ),
                ),
              ),
            ),
            body: (state is InitialCoursesUdemyAppSates||state is ErrorCourseUdemyAppSates)
                ? Center(
              child: Container(
                child: SpinKitWave(
                  color: Color(0xff99CAE1),
                  size: 30.0,
                ),
              ),
              ////categories
            )
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Category",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                          itemCount: UdemyCubit.get(context).cats.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, int index) {
                            return CategoryTile(
                              imageURL: UdemyCubit.get(context).cats[index].imageURL,
                              color: UdemyCubit.get(context).cats[index].color,
                              categoryName: UdemyCubit.get(context).cats[index].categoryName,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Courses",
                        style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: UdemyCubit.get(context).courses.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, int index) {
                            return CourseTile(
                              imageURL: UdemyCubit.get(context).courses[index].image,
                              title: UdemyCubit.get(context).courses[index].heading,
                              courseURL: UdemyCubit.get(context).courses[index].courseLink,
                              successRate: '',

                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
