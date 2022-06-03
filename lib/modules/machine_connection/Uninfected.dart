//ignore_for_file: must_be_immutable
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../myTest/audioCall.dart';
import '../../myTest/videoCall.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
class UnifectedScreen extends StatelessWidget {
  const UnifectedScreen({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                titleSpacing: 0.0,
                title:const Text(
                    'Infected Page'
                )
            ),
          );
        });
  }
}