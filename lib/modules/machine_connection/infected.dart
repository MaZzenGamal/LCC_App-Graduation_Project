
//ignore_for_file: must_be_immutable
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import '../../shared/components/components.dart';
import '../reservation_screen/doctors.dart';
class InfectedScreen extends StatelessWidget {
  final String label;
  final double degree;
  final String type;
  const InfectedScreen({Key? key,required this.label,required this.degree,required this.type})
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
                      'Uninfected Page'
                  )
              ),
              body:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children: [
                      Expanded(
                        child: Text(
                            'Unfortunately, there is bad news for you, which is that you have cancer of $label type and its degree is $degree And fearing for your health, we have provided you with a group of the best doctors in this specialty, so if you want to book with any of them, please choose OK'),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          AppCubit.get(context).searchController.text=type;
                          navigateTo(context,const DoctorsScreen());
                        },
                        child: const Text('OK'),
                      )]),
              )
          );
        });
  }
}

