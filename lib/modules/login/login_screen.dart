import 'package:flutter/material.dart';
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
                    isPassword: true,
                    prefix: Icons.lock_outline,
                    suffix: Icons.visibility
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
                    navigateTo(context,const RegisterScreen());
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
                        navigateTo(context,const RegisterScreen());
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
  }
}
