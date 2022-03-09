import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/modules/chat_screen/chat_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

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
