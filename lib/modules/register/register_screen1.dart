import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen1 extends StatelessWidget {
  const RegisterScreen1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();



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
          body: Container(
            constraints:const BoxConstraints.expand(),
            decoration:const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background2.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 20.0,
                top: 20.0
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
                        height: 5.0,
                      ),
                      Text(
                        'Create an account',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Please fill these forms',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize:23.0
                        ),),
                     const SizedBox(
                        height: 90.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultFormField(
                                controller: cubit.nameController,
                                type: TextInputType.text,
                                validate: (value) {
                                  //value.isEmpty
                                  if(((!RegExp(r'^[ء-ي_ ]+$').hasMatch(value))&&(!RegExp(r'^[a-zA Z_ ]+$').hasMatch(value)))||value!.isEmpty){
                                    return 'Please enter correct name name';
                                  }
                                },
                                label: 'Name',
                                prefix: Icons.person_outline),
                            const SizedBox(
                              height: 10.0,
                            ),
                            defaultFormField(
                                controller: cubit.emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty||!EmailValidator.validate(value)) {
                                    return 'Please enter valid email address';
                                  }
                                },
                                label: 'Email address',
                                prefix: Icons.email_outlined),
                            const SizedBox(
                              height: 10.0,
                            ),
                            defaultFormField(
                                controller: cubit.passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
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
                                controller: cubit.passwordConfController,
                                type: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Confirm your password';
                                  }
                                  if (value!= cubit.passwordController.text)
                                  {
                                    return 'password not match confirm password please try again' ;
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
                     const SizedBox(
                        height: 50.0,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: defaultButton(
                            width: 100.0,
                            function: ()
                            {
                              if (formKey.currentState!.validate()) {
                                print(cubit.nameController.text);
                                print(cubit.emailController.text);
                                print(cubit.passwordController.text);
                                print(cubit.passwordConfController.text);
                                navigateTo(context, const RegisterScreen2());
                              }
                              //navigateTo(context, const RegisterScreen2());
                            },
                            text: 'Next'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
