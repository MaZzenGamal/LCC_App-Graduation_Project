import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen2.dart';
import 'package:graduation_project/modules/register/register_scrreen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:numberpicker/numberpicker.dart';

class SelectAgeScreen extends StatelessWidget {
  const SelectAgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body:AlertDialog(
            title: Text('select your age'),
            content: NumberPicker(
                minValue: 10,
                maxValue: 100,
                value:cubit.age  ,
                onChanged: (value){
                  cubit.selectAge(value);
                }),
            actions: [
              TextButton(onPressed: (){
                navigateTo(context, RegisterScreen2());
              },
                  child: Text('Ok')),
            ],
          )
          ,
        );
      },
    );
  }
}
