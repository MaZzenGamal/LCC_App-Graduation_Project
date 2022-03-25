import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/select_age/select_age_profile_screen.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

import '../select_age/select_age_register_screen.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {} ,
      builder: (context,state){

        var profileImage = AppCubit.get(context).profileImage;
        var patModel = AppCubit.get(context).patModel;
        var cubit = AppCubit.get(context);
        var formKey = GlobalKey<FormState>();
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var genderController = TextEditingController();
        var addressController = TextEditingController();
        var ageController = TextEditingController();


        nameController.text =patModel.fullName!;
        emailController.text =patModel.email!;
        phoneController.text =patModel.phone!;
        genderController.text =patModel.gender!;
        addressController.text =patModel.address!;
        ageController.text =patModel.age!;


        return Scaffold(
          appBar: AppBar(
            title: const Text('profile'),
            actions: [
              defaultTextButton(
                  function: (){
                    if(cubit.profileImage == null){
                    cubit.updatePatProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        age: ageController.text,
                        gender: genderController.text,);}
                    else{
                      cubit.uploadPatProfileImage(
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          age: ageController.text,
                          gender: genderController.text,);}
                   },
                  text: 'Update'),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UpdatePatProfileLoadingState)
                    const LinearProgressIndicator(),
                  if(state is UpdatePatProfileLoadingState)
                    const SizedBox(height: 10.0,),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 70.0 ,
                              child: CircleAvatar(
                                radius: 70.0,
                                backgroundColor: Colors.white,
                                backgroundImage: profileImage == null? NetworkImage(
                                  '${patModel.image}',
                                ) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            if(state is UploadPatProfileImageLoadingState)
                              CircleAvatar(
                                radius: 70.0,
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                child:const CircularProgressIndicator(
                                  color: Colors.white,
                                ) ,
                              ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          radius: 16,
                          child: IconButton(
                              splashRadius: 25.0,
                              onPressed: ()
                              {
                                cubit.getProfileImage();
                              },
                              icon: const Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: 16.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      hint: '${patModel.fullName}',
                      label: 'Name',
                      prefix: Icons.person),
                  const SizedBox(
                    height: 12.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value){
                        if(value.isEmpty){
                          return 'please enter your email address';
                        }
                        return null;
                      },
                      hint: '${patModel.email}',
                      label: 'Email address',
                      prefix: Icons.email),
                  const SizedBox(
                    height: 12.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value){
                        if(value.isEmpty){
                          return'please enter your phone number';
                        }
                        return null;
                      },
                      hint: '${patModel.phone}',
                      label: 'Phone',
                      prefix: Icons.phone_android),
                  const SizedBox(
                    height: 12.0,
                  ),
            Row(
              children: [
                SizedBox(
                  width: 170.0,
                  child: defaultFormField(
                      controller: ageController,
                      type: TextInputType.number,
                      validate: (value){
                        if(value.isEmpty){
                          return'please enter your age';
                        }
                        return null;
                      },
                      hint: '${patModel.age}',
                      label: 'Age',
                      prefix: Icons.calendar_today),
                ),
                const Spacer(),
                SizedBox(
                  width: 170.0,
                  child: defaultFormField(
                      controller: genderController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty){
                          return'please enter your gender';
                        }
                        return null;
                      },
                      hint: '${patModel.gender}',
                      label:'Gender',
                      prefix: Icons.male),
                ),
              ],
            ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  defaultFormField(
                      controller: addressController,
                      type: TextInputType.streetAddress,
                      validate: (value){
                        if(value.isEmpty){
                          return'please enter your address';
                        }
                        return null;
                      },
                      hint: '${patModel.address}',
                      label: 'Address',
                      prefix: Icons.home),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
