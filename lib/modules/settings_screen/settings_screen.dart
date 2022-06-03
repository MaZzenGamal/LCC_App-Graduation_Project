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
import '../login/cubit/login_cubit.dart';
import '../profile_screen/patient_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppCubit.get(context).getUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              var profileImage = AppCubit
                  .get(context)
                  .profileImage;
              final listTiles = <Widget>[
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
                          cubit.usermodel.type == 'doctor' ? NetworkImage(
                              '${docModel.image}') : NetworkImage(
                              '${patModel.image}')
                      ),
                    ),
                    title: Text(
                      cubit.usermodel.type == 'doctor'
                          ? '${docModel.fullName}'
                          : '${patModel.fullName}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black
                      ),
                    ),
                    subtitle: const Text('Profile'),
                    onTap: () {
                      if (cubit.usermodel.type == 'doctor') {
                        navigateTo(context, const DoctorProfileScreen());
                      } else if (cubit.usermodel.type == 'patient') {
                        navigateTo(context, const PatientProfileScreen());
                      }
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
                      await context.read<LoginCubit>().signOut();
                      AppCubit.get(context).currentIndex=2;
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
                      navigateTo(context, const DoctorsScreen());
                    }
                ),
              ];
              return ListView(children: listTiles,);
            },
          );
        },);
  }
}
