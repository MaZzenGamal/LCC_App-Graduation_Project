import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

class RegisterScreen1 extends StatelessWidget {
  const RegisterScreen1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordConfController = TextEditingController();


    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state)
      {
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title:const Text(
                'Register'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // PAGE INDICATOR//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors.green,
                          ),
                        ),
                       const SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          height: 1,
                          width: 30,
                          color: Colors.grey[300],
                        ),
                       const SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                       const SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          height: 1,
                          width: 30,
                          color: Colors.grey[300],
                        ),
                       const SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                   const SizedBox(
                      height: 130.0,
                    ),
                    Card(
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultFormField(
                                controller: nameController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                },
                                label: 'Name',
                                prefix: Icons.person_outline),
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
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(
                      height: 50.0,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: defaultButton(
                          width: 100.0,
                          function: ()
                          {
                            // if (formKey.currentState!.validate()) {
                            //   print(nameController.text);
                            //   print(emailController.text);
                            //   print(passwordController.text);
                            //   print(passwordConfController.text);
                            //
                            //   cubit.pageInd=true;
                            //   cubit.counter++;
                            // }
                            navigateTo(context, const RegisterScreen2());
                          },
                          text: 'Next'),
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
