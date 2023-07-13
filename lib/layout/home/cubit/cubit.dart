import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_free_courses/layout/home/cubit/states.dart';
import 'package:udemy_free_courses/models/category_model.dart';
import 'package:udemy_free_courses/models/course_model.dart';
import 'package:udemy_free_courses/shared/components/constants.dart';
import 'package:udemy_free_courses/shared/network/remote/dio_helper.dart';

class UdemyCubit extends Cubit<UdemyAppSates> {
  UdemyCubit() : super(InitialUdemyAppStates());

  static UdemyCubit get(context) => BlocProvider.of(context);

  //course
  List<CourseModel> courses = [];

  Future<void> getCourse() async {
    emit(InitialCoursesUdemyAppSates());
    DioHelper.getData(url: Course_URL).then((value) {
      value.data.forEach((element) {
        CourseModel courseModel = CourseModel(
          heading: element['title'],
          image: element['image'],
          courseLink: element['link'],
          successRate: '',
        );
        courses.add(courseModel);
        emit(SuccessCoursesUdemyAppSates());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCourseUdemyAppSates());
    });
  }

  //category
  List<CategoryModel> cats = [];
  List<CourseModel> courseCats = [];

  Future<void> getCat(String cat) async {
    emit(InitialCatUdemyAppSates());
    DioHelper.getData(url: Cat_URL).then((value) {
      value.data.forEach((element) {
        CourseModel courseModel = CourseModel(
          heading: element['title'],
          image: element['image'],
          courseLink: element['link'],
          successRate: '',
        );
        courseCats.add(courseModel);
        emit(SuccessCatUdemyAppSates());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCatUdemyAppSates());
    });
  }

  //manual cat
  List<CategoryModel> category = <CategoryModel>[];
  void getCategories() {
    CategoryModel categoryModel;
    //1
    categoryModel = new CategoryModel(
        imageURL: "assets/images/dev.svg",
        categoryName: "Development",
        color:  Color(0xff99CAE1));
    category.add(categoryModel);

    //2
    categoryModel = new CategoryModel(
        imageURL: "assets/images/netwrk.svg",
        categoryName: "Networking",
        color:  Color(0xffE19999));
    category.add(categoryModel);

    //3
    categoryModel = new CategoryModel(
        imageURL: "assets/images/web.svg",
        categoryName: "Web",
        color:  Color(0xff9EE199));
    category.add(categoryModel);

    //4
    categoryModel = new CategoryModel(
        imageURL: "assets/images/dev.svg",
        categoryName: "Office-Productivity",
        color:  Color(0xff99CAE1));
    category.add(categoryModel);

    //5
    categoryModel = new CategoryModel(
        imageURL: "assets/images/web.svg",
        categoryName: "Personal-Development",
        color:  Color(0xffE19999));
    category.add(categoryModel);

    //6
    categoryModel = new CategoryModel(
        imageURL: "assets/images/dev.svg",
        categoryName: "Design",
        color:  Color(0xff9EE199));
    category.add(categoryModel);

    //7
    categoryModel = new CategoryModel(
        imageURL: "assets/images/netwrk.svg",
        categoryName: "Marketing",
        color:  Color(0xffE19999));
    category.add(categoryModel);

    //8
    categoryModel = new CategoryModel(
        imageURL: "assets/images/web.svg",
        categoryName: "Language",
        color:  Color(0xff99CAE1));
    category.add(categoryModel);

    //9
    categoryModel = new CategoryModel(
        imageURL: "assets/images/dev.svg",
        categoryName: "Test-Prep",
        color:  Color(0xff9EE199));
    category.add(categoryModel);

  }
  bool _loading = true;


}
