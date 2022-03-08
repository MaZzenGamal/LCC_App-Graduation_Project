import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_layout.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/select_age/select_age_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numberpicker/numberpicker.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      var cubit = RegisterCubit.get(context);
      var formKey = GlobalKey<FormState>();
      var firstNameController = TextEditingController();
      var lastNameController = TextEditingController();
      var emailController = TextEditingController();
      var passwordController = TextEditingController();
      var passwordConfController = TextEditingController();
      var phoneController = TextEditingController();
      var docIdController = TextEditingController();
      var universityController = TextEditingController();
      var specialController = TextEditingController();
      return BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(cubit.doctor==true)
            {
              if(!(state is DoctorCreateErrorState)){
                showToast(text: 'Account created successfully', state: ToastStates.SUCCESS);
                navigateTo(context, const PatientLayout());
              }
            }
          else if(cubit.doctor==false)
            {
              if(!(state is PatientCreateErrorState)){
                showToast(text: 'Account created successfully', state: ToastStates.SUCCESS);
                navigateTo(context, const PatientLayout());
              }
            }
         /* if(state is LoginErrorState){
            showToast(
                text: 'Failed, please enter valid email or password', state: ToastStates.ERROR
            );
          }
          if(state is LoginSuccessState ){
            navigateTo(context, const PatientLayout());
          }*/
        },
        builder: (context,state){

          return  Scaffold(
            appBar: AppBar(
              title: Text(
                'Register'
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: defaultFormField(
                                controller: firstNameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Your first name';
                                  }
                                },
                                label: 'First name',
                                prefix: Icons.person_outline),
                          ),
                          const SizedBox(
                            width: 10.0,),
                          Expanded(
                            child: defaultFormField(
                                controller: lastNameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Your last name';
                                  }
                                },
                                label: 'Last name',
                                prefix: Icons.person_outline),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          label: 'Email address',
                          prefix: Icons.email_outlined),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                          },
                          label: 'Password',
                          isPassword: cubit.isPassword,
                          prefix: Icons.lock_outline,
                          suffix: cubit.suffix,
                          suffixPressed: (){
                            cubit.changePasswordVisibility();
                          }
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                          controller: passwordConfController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Confirm your password';
                            }
                            if (value!= passwordController.text)
                              {
                                return 'Not Match' ;
                              }
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_outline,
                          suffix: cubit.suffix2,
                          suffixPressed: (){
                            cubit.changeConfPasswordVisibility();
                          },
                          isPassword: cubit.isPassword2),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone_android),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          MaterialButton(onPressed: ()
                          {
                            navigateTo(context, SelectAgeScreen());
                          },
                            height: 50,
                            color:Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),),
                            child: Text('Select your age',
                            style: TextStyle(
                              color:  HexColor('4E51BF')
                            ),),
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                              'Age : ${cubit.age}'
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 10.0,
                      // ),
                      // TextFormField(
                      //     controller: specialController,
                      //     enabled: false,
                      //     cursorColor: HexColor('4E51BF'),
                      //     validator:cubit.flag? (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please enter your your specialization';
                      //       }
                      //     }:null,
                      //     style: TextStyle(
                      //         color: Colors.black
                      //     ),
                      //     decoration: InputDecoration(
                      //
                      //       labelText: '${cubit.age}',
                      //       alignLabelWithHint: true,
                      //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //       labelStyle: TextStyle(
                      //         color:Colors.grey[400] ,
                      //       ),
                      //       fillColor:Colors.grey[200] ,
                      //       filled: true,
                      //       errorBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(color: Colors.red,
                      //             width: 2.0),
                      //         borderRadius: BorderRadius.circular(50.0),
                      //       ),
                      //       focusedErrorBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: HexColor('4E51BF'),
                      //             width: 2.0),
                      //         borderRadius: BorderRadius.circular(50.0),),
                      //       border: const OutlineInputBorder(
                      //           borderRadius: BorderRadius.all(Radius.circular(
                      //               90.0)),
                      //           borderSide: BorderSide.none
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: HexColor('4E51BF'),
                      //             width: 2.0),
                      //         borderRadius: BorderRadius.circular(50.0),
                      //       ),
                      //       prefixIcon:Padding(
                      //         padding: EdgeInsets.symmetric(horizontal:4.0),
                      //         child: MaterialButton(
                      //           onPressed: ()
                      //           {
                      //             navigateTo(context, SelectAgeScreen());
                      //           },
                      //           height: 50,
                      //           color: Colors.grey[200],
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(50.0),),
                      //           child: Text('Select your age',
                      //             style:TextStyle(
                      //               color: HexColor('4E51BF')
                      //             ) ,
                      //           ),
                      //         ),
                      //       )
                      //     )
                      // ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Patient'),
                              leading: Radio<condition>(
                                value: condition.patient,
                                groupValue: cubit.val,
                                onChanged: (condition? value) {
                                  cubit.radioPatient(value);
                                },
                                activeColor: HexColor('4E51BF'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Doctor'),
                              leading: Radio<condition>(
                                value: condition.doctor,
                                groupValue: cubit.val,
                                onChanged: (condition? value) {
                                  cubit.radioDoctor(value);
                                },
                                activeColor: HexColor('4E51BF'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                          controller: docIdController,
                          keyboardType: TextInputType.phone,
                          enabled: cubit.doctor ? true : false,
                          cursorColor: HexColor('4E51BF'),
                          validator:cubit.doctor? (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your ID';
                            }
                          }:null,
                          style: TextStyle(
                            color: cubit.doctor ? Colors.black : Colors.grey[300]
                          ),
                          decoration: InputDecoration(
                            labelText: 'Doctor id',
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            floatingLabelStyle: TextStyle(
                                color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                            labelStyle: TextStyle(
                              color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                            ),
                            fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                            filled: true,
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    90.0)),
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            prefixIcon: Icon(Icons.credit_card,
                              color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          controller: universityController,
                          keyboardType: TextInputType.text,
                          enabled: cubit.doctor ? true : false,
                          cursorColor: HexColor('4E51BF'),
                          validator:cubit.doctor? (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your the university';
                            }
                          }:null,
                          style: TextStyle(
                            color: cubit.doctor ? Colors.black : Colors.grey[300]
                          ),
                          decoration: InputDecoration(
                            labelText: 'University',
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            floatingLabelStyle: TextStyle(
                                color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                            labelStyle: TextStyle(
                              color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                            ),
                            fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                            filled: true,
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    90.0)),
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            prefixIcon: Icon(Icons.school_outlined,
                              color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          controller: specialController,
                          keyboardType: TextInputType.text,
                          enabled: cubit.doctor ? true : false,
                          cursorColor: HexColor('4E51BF'),
                          validator:cubit.doctor? (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your your specialization';
                            }
                          }:null,
                          style: TextStyle(
                            color: cubit.doctor ? Colors.black : Colors.grey[300]
                          ),
                          decoration: InputDecoration(
                            labelText: 'Specialization',
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            floatingLabelStyle: TextStyle(
                                color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                            labelStyle: TextStyle(
                              color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                            ),
                            fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                            filled: true,
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    90.0)),
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor('4E51BF'),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            prefixIcon: Icon(Icons.medical_services_outlined,
                              color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                          )),
                      //readOnly: flag  ? false : true ,
                      const SizedBox(
                        height: 20.0,
                      ),
                      //
                      defaultButton(function: () {
                        if (formKey.currentState!.validate()) {
                          print(firstNameController.text);
                          print(lastNameController.text);
                          print(emailController.text);
                          print(passwordController.text);
                          print(passwordConfController.text);
                          print(phoneController.text);
                          navigateTo(context, const PatientLayout());
                        }
                      },
                          text: 'register'),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: myDivider()),
                          const Text('Or',
                            style: TextStyle(
                                color: Colors.grey
                            ),),
                          Expanded(child: myDivider()),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(SocialIcons.facebook_rect,
                            color: Colors.blue,),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(SocialIcons.googleplus_rect,
                            color: Colors.red,),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(SocialIcons.github,
                            color: Colors.red,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}