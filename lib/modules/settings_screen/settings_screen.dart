// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/modules/cancer%20_informations/cancer_info_screen.dart';
// import 'package:graduation_project/modules/language/languages_screen.dart';
// import 'package:graduation_project/modules/profile_screen/doctor_profile_screen.dart';
// import 'package:graduation_project/shared/components/components.dart';
//
// import '../../layouts/app_layout/app_cubit.dart';
// import '../../layouts/app_layout/states.dart';
// import '../profile_screen/patient_profile_screen.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppStates>(
//     listener: (context, state) {} ,
//     builder: (context,state){
//       var cubit = AppCubit.get(context);
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.separated(
//           physics:BouncingScrollPhysics() ,
//           itemBuilder: (context,index)=>InkWell(
//             child: Container(
//               height: 80.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Profile',
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodyText1,
//                   ),
//                 ],
//               ),
//             ),
//             onTap: (){
//               if(cubit.type == 'doctor')
//                 {
//                   navigateTo(context, DoctorProfileScreen());
//                 }else if (cubit.type == 'patient')
//                   {
//                     navigateTo(context, PatientProfileScreen());
//                   }
//             },
//           ),
//           separatorBuilder: (context,index)=>myDivider(),
//           itemCount: 1),
//       );
//     });
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/profile_screen/doctor_profile_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../layouts/app_layout/app_cubit.dart';
import '../../layouts/app_layout/states.dart';
import '../login/cubit/login_cubit.dart';
import '../profile_screen/patient_profile_screen.dart';
import '../reservation_screen/doctor_information_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              var docModel = AppCubit
                  .get(context)
                  .docModel;
              var patModel = AppCubit
                  .get(context)
                  .patModel;
            late List<Widget> listTiles = <Widget>[];
              cubit.usermodel.type == 'doctor' ? listTiles=[
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage(
                          'assets/images/loading photo.jpg'),
                      radius: 30.0,
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white.withOpacity(0.6),
                          backgroundImage:
                           NetworkImage(
                              '${docModel.image}')
                      ),
                    ),
                    title: Text(
                    '${docModel.fullName}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    subtitle: const Text('Profile'),
                    onTap: () {
                        navigateTo(context, const DoctorProfileScreen());
                    }
                ),
                const Divider(),
                ListTile(
                    leading: const Icon(
                        Icons.error
                    ),
                    title: const Text('Logout',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    onTap: () async {
                      try{
                        await context.read<LoginCubit>().signOut();
                        AppCubit.get(context).currentIndex=2;

                      }catch(c){
                        if (kDebugMode) {
                          print(c.toString());
                        }
                      }
                      if(FirebaseAuth.instance.currentUser==null)
                        {
                          navigateTo(context,LoginScreen());
                        }
                      //await AppCubit.get(context).signOut();
                      // RestartWidget.restartApp(context);
                      // navigateAndFinish(context, LoginScreen());
                    }
                ),
                const Divider(),
                ListTile(
                    leading: const Icon(
                        Icons.medical_services_outlined
                    ),
                    title: const Text('Doctor Screen',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    onTap: () {
                      navigateTo(context,DoctorsInformation (docModel: AppCubit.get(context).docModel));
                    }
                ),
              ]:listTiles=[
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage(
                          'assets/images/loading photo.jpg'),
                      radius: 30.0,
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white.withOpacity(0.6),
                          backgroundImage:
                          NetworkImage(
                              '${patModel.image}')
                      ),
                    ),
                    title: Text(
                      '${patModel.fullName}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    subtitle: const Text('Profile'),
                    onTap: () {
                      navigateTo(context, const PatientProfileScreen());
                    }
                ),
                const Divider(),
                ListTile(
                    leading: const Icon(
                        Icons.error
                    ),
                    title: const Text('Logout',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    onTap: () async {
                      try{
                        await context.read<LoginCubit>().signOut();
                        AppCubit.get(context).currentIndex=2;

                      }catch(c){
                        if (kDebugMode) {
                          print(c.toString());
                        }
                      }
                      if(FirebaseAuth.instance.currentUser==null)
                      {
                        navigateTo(context,LoginScreen());
                      }
                    }
                ),
              ];
              return ListView(children: listTiles,);
            },
          );

  }
}
