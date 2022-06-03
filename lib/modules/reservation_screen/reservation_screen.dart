import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
          stream:AppCubit.get(context).checkHoliday() ,
          builder: (BuildContext context, _) {
            return BlocConsumer<AppCubit,AppStates>(
              listener: (context,state){},
              builder: (context,state){
                //AppCubit.get(context).timeOfWork(startTime: 11:47:00, endTime: 13:00);
                return Scaffold(
                  appBar: AppBar(),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.teal[100]
                        ) ,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DatePicker(
                            DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Colors.black,
                            selectedTextColor: Colors.white,
                           inactiveDates:AppCubit.get(context).dates,
                            onDateChange: (date) {
                              // New date selected
                              AppCubit.get(context).dateSelectedValue=date;
                            },
                          ),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                            itemBuilder: (context, index)=>timePicker(context,AppCubit.get(context).times[index]),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => Container(),
                            itemCount: 20),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        );
      }
  Widget timePicker(context,DateTime workTime) => InkWell(
    onTap:(){
    },
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color:HexColor('89CFF0'),
          color:AppCubit.get(context).timeSelectedValue == workTime ? Colors.black : Colors.teal[100],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0,top:10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${DateFormat('hh:mm:ss').format(workTime)}workTime',
                style: TextStyle(
                    color: AppCubit.get(context).timeSelectedValue == workTime ? Colors.white : Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}