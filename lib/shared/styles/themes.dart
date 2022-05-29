import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(

  appBarTheme:const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontFamily:'Georama',
      fontWeight: FontWeight.bold
    ),
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    ) ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      //HexColor('#F4433600'),
      statusBarIconBrightness: Brightness.dark,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
  ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Colors.blue,
        elevation: 30.0
    ),
  textTheme:const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )
  ),
    fontFamily: 'Georama'
);

ThemeData darkTheme = ThemeData(
  appBarTheme:const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontFamily:'Georama',
      fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black54,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
  ),
  backgroundColor: Colors.black54,
    scaffoldBackgroundColor: Colors.black54,
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        backgroundColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Colors.blue,
        elevation: 30.0
    ),
  textTheme:const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )
  ),
    fontFamily: 'Georama'
);