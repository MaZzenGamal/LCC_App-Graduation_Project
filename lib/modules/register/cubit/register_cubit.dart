// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/phone_model.dart';
import '../../../models/user_model.dart';

enum condition {patient , doctor}

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super (RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var specialtyController = TextEditingController();
  var universityController = TextEditingController();
  var certificateController = TextEditingController();
  var registrationNuController = TextEditingController();


  condition? val = condition.patient;
  bool doctor = false;
  //int age = 25;
  bool visible1=false;
  void radioPatient(value){
    val = value;
    doctor = false;
    visible1=false;
    emit(RegisterRadioPatientState());
  }

  void radioDoctor(value){
    val = value;
    doctor = true;
    visible1=false;
    emit(RegisterRadioDoctorState());
  }


  // void selectAge(value){
  //   age = value;
  //   emit(RegisterAgeValueState());
  // }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility : Icons.visibility_off ;
    emit(RegisterPasswordVisibilityState());
  }

  IconData suffix2 = Icons.visibility;
  bool isPassword2 = true;

  void changeConfPasswordVisibility()
  {
    isPassword2 = !isPassword2;
    suffix2 = isPassword2? Icons.visibility : Icons.visibility_off ;
    emit(RegisterConfPasswordVisibilityState());
  }

  IconData suffixLogin = Icons.visibility;
  bool isPasswordLogin = true;
  void changeLoginPasswordVisibility()
  {
    isPasswordLogin = !isPasswordLogin;
    suffixLogin = isPasswordLogin? Icons.visibility : Icons.visibility_off ;
    emit(LoginPasswordVisibilityState());
  }

  String gender ='Male';
  bool chosenGender = false;
  void changeExpansionToMale(){
    gender = 'Male';
    chosenGender = true;
    emit(ExpansionTitleMaleState());
  }

  void changeExpansionToFemale(){
    gender = 'Female';
    chosenGender = true;
    emit(ExpansionTitleFemaleState());
  }

  String status = 'Single';
  bool chosenStatus = false;
  void changeExpansionToSingle(){
    status = 'Single';
    chosenStatus = true;
    emit(ExpansionTitleSingleState());
  }

  void changeExpansionToMarried(){
    status = 'Married';
    chosenStatus = true;
    emit(ExpansionTitleMarriedState());
  }

  void changeExpansionToWidowed(){
    status = 'Widowed';
    chosenStatus = true;
    emit(ExpansionTitleWidowedState());
  }

  void changeExpansionToDivorced(){
    status = 'Divorced';
    chosenStatus = true;
    emit(ExpansionTitleDivorcedState());
  }

  File? profileImage;
  bool image=false;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image=true;
      print('image picked');
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('No image selected');
      image=false;
      emit(ProfileImagePickerErrorState());
    }
  }
  void profileImageValidation(){
    visible1=true;
  emit(ProfileImageValidationState());
  }

  void patientRegister({
    required String email,
    required String fullName,
    required String password,
    required String phone,
    required String gender,
    required String address,
    required String age,
  }){
    emit(PatientRegisterLoadingState());
    String? tokenm;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      tokenm=token!;
      print(token); // Print the Token in Console
    });
    //final FirebaseMessaging _fcm=FirebaseMessaging();
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value)
    {
        patientCreate(
          email: email,
          fullName: fullName,
          phone: phone,
          uId: value.user!.uid,
          age: age,
          gender: gender,
          address: address,
          token: tokenm!,
          createdAt: DateTime.now(),
        );
    }).catchError((error){
      var index=(error.toString()).indexOf(']');
      String showerror=(error.toString()).substring(index+1);
      showToast(text: showerror, state: ToastStates.ERROR);
      print(error);
      emit(PatientRegisterErrorState(error.toString()));
    });
  }

  void patientCreate({
    required String email,
    required String fullName,
    required String phone,
    required String uId,
    required String gender,
    required String address,
    required String age,
    required String token,
    required DateTime createdAt,
  }){
    PatientModel model = PatientModel(
      email: email,
      fullName: fullName,
      phone: phone,
      uId: uId,
      image: 'https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png',
      age: age,
      gender: gender,
      address:address,
      token:token,
      createdAt:createdAt,
    );
    FirebaseFirestore.instance.
    collection('patient').
    doc(uId).
    set(model.toMap())
        .then((value)
    {
      UserModel user = UserModel(
        email: email,
        uId: uId,
        type: "patient",
        status:'online',
        name: fullName,
        gender: gender,
      );
      FirebaseFirestore.instance.
      collection('user').
      doc(uId).
      set(user.toMap());
      PhoneModel phone1 = PhoneModel(
        phone: phone,
        uId: uId,
      ) ;
      FirebaseFirestore.instance.
      collection('Phone').doc(uId).
      set(phone1.toMap());
      showToast(text: 'Account created successfully', state: ToastStates.SUCCESS);
      emit(PatientCreateSuccessState());
     }).catchError((error)
    {
      showToast(text: 'Failed, please check your connection', state: ToastStates.ERROR);
      print(error.toString);
      emit(PatientCreateErrorState(error.toString()));
    });
  }


  void doctorRegister({
    required String email,
    required String fullName,
    required String password,
    required String phone,
    required String gender,
    required String address,
    required String university,
    required String specialization,
    required String certificates,
    required String regisNumber,
    required String age,

  }){
    emit(PatientRegisterLoadingState());
    String? tokenm;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      tokenm=token!;
      print(token); // Print the Token in Console
    });
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value)
    {
        doctorCreate(
          email: email,
          fullName: fullName,
          phone: phone,
          uId: value.user!.uid,
          age: age,
          gender: gender,
          address: address,
          regisNumber: regisNumber,
          specialization: specialization,
          university: university,
          certificates: certificates,
          token: tokenm!,
          createdAt: DateTime.now(),
        );
    }).catchError((error){
      var index=(error.toString()).indexOf(']');
      String showerror=(error.toString()).substring(index+1);
      showToast(text: showerror, state: ToastStates.ERROR);
      print(error);
      emit(DoctorRegisterErrorState(error.toString()));
    });
  }

  void doctorCreate({
    required String email,
    required String fullName,
    required String uId,
    required String phone,
    required String gender,
    required String address,
    required String university,
    required String specialization,
    required String certificates,
    required String regisNumber,
    required String age,
    required String token,
    required DateTime createdAt,
  }){
    DoctorModel model = DoctorModel(
        email: email,
        fullName: fullName,
        phone: phone,
        uId: uId,
        image: 'https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png',
        age: age,
        gender: gender,
        address:address,
      certificates: certificates,
      regisNumber: regisNumber,
      specialization: specialization,
      university: university,
      token:token,
      createdAt:createdAt,
      allRateNumber: 0,
      allRateValue: 0.00001,
      rate: 0.00001,
    );
    FirebaseFirestore.instance.
    collection('doctor').
    doc(uId).
    set(model.toMap())
        .then((value)
    {
      UserModel user = UserModel(
        email: email,
        uId: uId,
        type: "doctor",
        gender: gender,
        status: 'online',
        name:fullName,
      );
      FirebaseFirestore.instance.
      collection('user').
      doc(uId).
      set(user.toMap());
      PhoneModel phone1 = PhoneModel(
       phone: phone,
        uId: uId,
      ) ;
      FirebaseFirestore.instance.
      collection('Phone').doc(uId).
      set(phone1.toMap());
      showToast(text: 'Account created successfully', state: ToastStates.SUCCESS);
      emit(DoctorCreateSuccessState());
    }).catchError((error)
    {
      showToast(text: 'Failed, please check your connection', state: ToastStates.ERROR);
      print(error.toString);
      emit(DoctorCreateErrorState(error.toString()));
    });
  }

}

Future<bool> checkExist(String phone) async {
  try {
    await FirebaseFirestore.instance.collection("phone/$phone").get().then((phone) {
    });
    return true;
  } catch (e) {
    // If any error
    return false;
  }
}