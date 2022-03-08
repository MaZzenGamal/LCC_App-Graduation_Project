import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  //LoginCubit(LoginStates initialState) : super(initialState);
  LoginCubit():super (LoginInitialState()) ;


  //LoginCubit() : super (InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
  required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      var index=(error.toString()).indexOf(']');
      String showerror=(error.toString()).substring(index+1);
      showToast(
          text: '${showerror}', state: ToastStates.ERROR
      );
      emit(LoginErrorState(error.toString()));
    });

  }

}
