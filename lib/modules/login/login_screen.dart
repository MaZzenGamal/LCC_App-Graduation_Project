import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/patient_layout.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen1.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/login_cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
        if(state is LoginSuccessState ){
          CacheHelper.saveData(key: 'uId', value: state.uId);
          navigateTo(context, const AppLayout());
          }

    },
        builder: (context,state){
          return Scaffold(
              body: Container(
                constraints:const BoxConstraints.expand(),
                decoration:const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background2.jpg'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 70.0,
                          ),
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Welcome',
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.white,
                              fontSize: 43.0
                            ),),
                          const SizedBox(
                            height: 120.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value){
                                if(value.isEmpty)
                                {
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
                              isPassword: RegisterCubit.get(context).isPasswordLogin,
                              prefix: Icons.lock_outline,
                              suffix: RegisterCubit.get(context).suffixLogin,
                              suffixPressed: (){
                                RegisterCubit.get(context).changeLoginPasswordVisibility();
                              }
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          //
                          BuildCondition(
                              condition: state is! LoginLoadingState ,
                              builder: (context)=> defaultButton(function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                print(emailController.text);
                                print(passwordController.text);
                                LoginCubit.get(context).userLogin(
                                 email: emailController.text,
                                  password: passwordController.text,
                                );
                                //navigateTo(context,const PatientLayout());
                              }
                            },
                                text: 'login'),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),

                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Dont have an account ?',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              TextButton(
                                onPressed: ()
                                {
                                  navigateTo(context,const RegisterScreen1());
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: HexColor('4E51BF')
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
