import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_layout.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen1.dart';
import 'package:graduation_project/modules/register/register_scrreen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,index){},
      builder: (context,index){
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    defaultButton(function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        print(emailController.text);
                        print(passwordController.text);
                        navigateTo(context,const PatientLayout());
                      }
                    },
                        text: 'login'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account ?',
                          style: TextStyle(
                              color: Colors.grey
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
            )
        );
      },
    );
  }
}
