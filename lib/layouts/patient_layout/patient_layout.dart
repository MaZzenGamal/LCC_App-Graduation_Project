import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/patient_cubit.dart';
import 'package:graduation_project/layouts/patient_layout/states.dart';
import 'package:graduation_project/modules/Patient/chat_screen/chat_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

class PatientLayout extends StatelessWidget {
  const PatientLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit,PatientStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = PatientCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text(
              cubit.titles[cubit.currentIndex],
            ),
            titleSpacing: 0,
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, ChatScreen());
                  },
                  icon: Icon(
                    Icons.chat_outlined
                  ))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20.0,
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBotNavBar(index);
            },
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
