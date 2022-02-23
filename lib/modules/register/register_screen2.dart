import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_layout.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/modules/select_age/select_age_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen2 extends StatelessWidget {
  const RegisterScreen2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();
    var addressController = TextEditingController();
    var phoneController = TextEditingController();
    var docIdController = TextEditingController();
    var universityController = TextEditingController();
    var specialController = TextEditingController();
    return BlocConsumer<RegisterCubit,RegisterStates>(

      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title:const Text(
                'Register'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // PAGE INDICATOR //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            // AGE //
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
                            const SizedBox(
                              height: 10.0,
                            ),
                            // GENDER //
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.grey[200],
                                  title: Text(
                                    cubit.chosenGender? cubit.gender:'Gender' ,
                                  ),
                                textColor: HexColor('4E51BF'),
                                collapsedTextColor:HexColor('4E51BF'),
                                children: [
                                  ListTile(
                                    title:const Text('Male'),
                                    onTap: (){
                                      cubit.changeExpansionToMale();
                                    },
                                  ),
                                  ListTile(
                                    title:const Text('Female'),
                                    onTap: (){
                                      cubit.changeExpansionToFemale();
                                    },
                                  ),
                                ],
                                onExpansionChanged: (isExpanded){
                                  print('Expanded: $isExpanded');
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            //MARITAL STATUS //
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.grey[200],
                                title:Text(
                                  cubit.chosenStatus? cubit.status:'Marital status' ,
                                 ),
                                textColor: HexColor('4E51BF'),
                                collapsedTextColor:HexColor('4E51BF'),
                                children: [
                                  ListTile(
                                    title:const Text('Single'),
                                    onTap: (){
                                      cubit.changeExpansionToSingle();
                                    },
                                  ),
                                  ListTile(
                                    title:const Text('Married'),
                                    onTap: (){
                                      cubit.changeExpansionToMarried();
                                    },
                                  ),
                                  ListTile(
                                    title:const Text('Divorced'),
                                    onTap: (){
                                      cubit.changeExpansionToDivorced();
                                    },
                                  ),
                                  ListTile(
                                    title:const Text('Widowed'),
                                    onTap: (){
                                      cubit.changeExpansionToWidowed();
                                    },
                                  ),
                                ],
                                onExpansionChanged: (isExpanded){
                                  print('Expanded: $isExpanded');
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            // ADDRESS //
                            defaultFormField(
                                controller: addressController,
                                type: TextInputType.streetAddress,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                },
                                label: 'Address',
                                prefix: Icons.home_outlined),
                            const SizedBox(
                              height: 10.0,
                            ),
                            // PHONE //
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
                            if (formKey.currentState!.validate()) {

                              print(addressController.text);
                              print(phoneController.text);
                              navigateTo(context, const RegisterScreen2());
                            }
                          },
                          text: 'Next'),
                    ),
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
