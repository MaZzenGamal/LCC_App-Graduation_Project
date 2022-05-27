import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../modules/chat_screen/chat_details_doctor_screen.dart';
import '../../modules/chat_screen/chat_details_patient_screen.dart';
import '../../modules/reservation_screen/doctor_reservation.dart';
import '../../modules/reservation_screen/patient_reservation.dart';
import '../../shared/network/local/cash_helper.dart';
import 'app_cubit.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            titleSpacing:8,
            title:Text(
              cubit.titles[cubit.currentIndex],
            ),
           // titleSpacing: 0,
            actions: [
              IconButton(
                  onPressed: (){
                    //AppCubit.get(context).getUsers();
                    var type=CacheHelper.getData(key: 'type');
                    if(type=="patient") {
                      navigateTo(context, const ChatDetailsDoctorScreen());
                    }
                    else if(type=="doctor") {
                      navigateTo(context, const ChatDetailsPatientScreen());
                    }
                  },
                  icon: const Icon(
                    Icons.chat_outlined
                  ))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{6: '99+'},
            style: cubit.tabStyle,
            elevation: 5.0,
            backgroundColor: HexColor('4E51BF'),
            initialActiveIndex: 2,
            items: <TabItem>[
              for (final entry in cubit.kPages.entries)
                TabItem(icon: entry.value, title: entry.key),
            ],
            onTap: (index){
              cubit.changeBotNavBar(index);
            },
          ),
        );
      },
    );
  }
}

