import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/states.dart';
import 'package:graduation_project/modules/Patient/home_screen/home_screen.dart';
import 'package:graduation_project/modules/Patient/search_screen/search_screen.dart';
import 'package:graduation_project/shared/styles/icon_broken.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';

class PatientCubit extends Cubit<PatientStates>{

  PatientCubit(): super(PatientInitialState());

  static PatientCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<String>titles=[
    'Home',
    'Search'
  ];
  List<Widget>screens=[
    HomeScreen(),
    SearchScreen()
  ];

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home
        ),
    label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
    label: 'search'),
  ];

  void changeBotNavBar(int index){
    currentIndex = index;
    if(index == 1)
      SearchScreen();
    emit(PatientBotNavState());
  }
}
