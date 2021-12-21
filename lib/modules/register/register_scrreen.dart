import 'package:flutter/material.dart';
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
    var ageController = TextEditingController();

    return Scaffold(
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
                Text('Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0
                ),),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: defaultFormField(
                          controller: firstNameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              return '';
                            }
                          },
                          label: 'First name',
                          prefix: Icons.person_outline),
                    ),
                    SizedBox(
                      width: 10.0,),
                    Expanded(
                      child: defaultFormField(
                          controller: lastNameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              return '';
                            }
                          },
                          label: 'Last name',
                          prefix: Icons.person_outline),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
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
                    isPassword: true,
                    prefix: Icons.lock_outline,
                    suffix: Icons.visibility
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                    controller: passwordConfController,
                    type: TextInputType.visiblePassword,
                    validate: (value)
                    {
                      if(formKey.currentState!.validate())
                      {
                        return '';
                      }
                    },
                    label: 'Confirm Password',
                    prefix: Icons.lock_outline,
                    suffix: Icons.visibility,
                    isPassword: true),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value)
                    {
                      if(formKey.currentState!.validate())
                      {
                        return '';
                      }
                    },
                    label: 'Phone',
                    prefix: Icons.phone_android),
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
                  }
                  navigateTo(context, RegisterScreen());
                },
                    text: 'register'),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: myDivider()),
                    Text('Or',
                    style: TextStyle(
                      color: Colors.grey
                    ),),
                    Expanded(child: myDivider()),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
  }
}
