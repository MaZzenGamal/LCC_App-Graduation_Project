// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
// import 'package:graduation_project/layouts/app_layout/states.dart';
// import 'package:graduation_project/modules/profile_screen/profile_screen.dart';
// import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
// import 'package:graduation_project/modules/register/cubit/states.dart';
// import 'package:graduation_project/modules/register/register_screen2.dart';
// import 'package:graduation_project/shared/components/components.dart';
// import 'package:numberpicker/numberpicker.dart';
//
// class SelectAgeProfileScreen extends StatelessWidget {
//   const SelectAgeProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = AppCubit.get(context);
//     return BlocConsumer<AppCubit,AppStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         return Scaffold(
//           body:AlertDialog(
//             title: Text('select your age'),
//             content: NumberPicker(
//                 minValue: 10,
//                 maxValue: 100,
//                 value:cubit.age  ,
//                 onChanged: (value){
//                   cubit.selectAge(value);
//                 }),
//             actions: [
//               TextButton(onPressed: (){
//                 navigateAndFinish(context, ProfileScreen());
//               },
//                   child: Text('Ok')),
//             ],
//           )
//           ,
//         );
//       },
//     );
//   }
// }
