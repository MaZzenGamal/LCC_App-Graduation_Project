import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_layout.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';
import 'package:hexcolor/hexcolor.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      var formKey = GlobalKey<FormState>();
      var firstNameController = TextEditingController();
      var lastNameController = TextEditingController();
      var emailController = TextEditingController();
      var passwordController = TextEditingController();
      var passwordConfController = TextEditingController();
      var phoneController = TextEditingController();
      var docIdController = TextEditingController();
      var ageController = TextEditingController();


      return BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return  Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0
                        ),),
                      const SizedBox(
                        height: 30.0,
                      ),
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
                          isPassword: true,
                          prefix: Icons.lock_outline,
                          suffix: Icons.visibility
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
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_outline,
                          suffix: Icons.visibility,
                          isPassword: true),
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
                          enabled: cubit.flag ? true : false,
                          cursorColor: HexColor('4E51BF'),
                          validator:cubit.flag? (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your ID';
                            }
                          }:null,
                          style: TextStyle(
                            color: cubit.flag ? Colors.black : Colors.grey[300]
                          ),
                          decoration: InputDecoration(
                            labelText: 'Doctor id',
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            floatingLabelStyle: TextStyle(
                                color: cubit.flag ? HexColor('4E51BF') : Colors.grey),
                            labelStyle: TextStyle(
                              color: cubit.flag ? Colors.grey[400] : Colors.grey[300],
                            ),
                            fillColor: cubit.flag ? Colors.grey[200] : Colors.grey[100],
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
                            prefixIcon: Icon(Icons.confirmation_number,
                              color: cubit.flag ? HexColor('4E51BF') : Colors.grey,),

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