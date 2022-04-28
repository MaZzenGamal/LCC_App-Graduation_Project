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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/profile_screen/doctor_profile_screen.dart';
import 'package:graduation_project/modules/reservation_screen/doctors.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../layouts/app_layout/app_cubit.dart';
import '../../layouts/app_layout/states.dart';
import '../../myTest/restart_screen.dart';
import '../profile_screen/patient_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
    listener: (context, state) {} ,
    builder: (context,state){
      var cubit = AppCubit.get(context);
      var docModel = AppCubit.get(context).docModel;
      var patModel = AppCubit.get(context).patModel;
      var profileImage = AppCubit.get(context).profileImage;
      final listTiles=<Widget>[
         ListTile(
           leading: CircleAvatar(
             backgroundColor: Colors.white,
             backgroundImage: AssetImage('assets/images/loading photo.jpg'),
             radius: 30.0 ,
             child: CircleAvatar(
               radius: 30.0,
               backgroundColor: Colors.white.withOpacity(0.6),
               backgroundImage:
               cubit.type == 'doctor'? NetworkImage('${docModel.image}'):NetworkImage('${patModel.image}')
             ),
           ) ,
          title: Text(
            cubit.type == 'doctor'? '${docModel.fullName}':'${patModel.fullName}',
            style:const TextStyle(
                fontSize: 25,
                color: Colors.black
            ),
          ),
          subtitle:const Text('Profile'),
          onTap:() {
            if(cubit.type=='doctor'){
              navigateTo(context,const DoctorProfileScreen());
            }else if(cubit.type == 'patient'){
              navigateTo(context,const PatientProfileScreen());
            }
      }
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.error
          ),
            title:const Text('Logout',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black
              ),
            ),
            onTap:() {
              RestartWidget.restartApp(context);
              navigateAndFinish(context, LoginScreen());
            }
        ),
        const Divider(),
        ListTile(
            leading: Icon(
                Icons.medical_services_outlined
            ),
            title:const Text('Doctor Screen',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black
              ),
            ),
            onTap:() {
              navigateTo(context, DoctorsScreen());
            }
        ),
      ];
      return ListView(children: listTiles,);
  },
  );
  }
}
