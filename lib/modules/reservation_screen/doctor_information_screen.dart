import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/comment_model.dart';
import 'package:graduation_project/modules/reservation_screen/review_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../models/doctor_model.dart';
import '../../models/patient_model.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';

class DoctorsInformation extends StatelessWidget {
  PatientModel? patModel;
  DoctorModel? docModel;
  int patientNumber = 300;
  //DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  DoctorsInformation({Key? key, this.docModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //navigatorKey=navigateTo(context,DoctorsInformation() );
    return StreamBuilder(
      stream:AppCubit.get(context).timeOfWork(startTime: docModel!.startTime!, endTime:docModel!.endTime!),
      builder: (BuildContext context,_) {
          return StreamBuilder(
              stream: AppCubit.get(context).checkHoliday(),
              builder: (BuildContext context, _) {
                return StreamBuilder<void>(
                    stream: AppCubit.get(context).getComment(
                        receiverId: docModel!.uId!),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return BlocConsumer<AppCubit, AppStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Scaffold(
                            appBar: AppBar(),
                            body: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        /*image: DecorationImage(
                                          image: NetworkImage(docModel!.image!),
                                          //image: NetworkImage("https://picsum.photos/id/237/200/300"),
                                          fit: BoxFit.cover),*/
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Dr.${docModel!.fullName}',
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          height: 1.3,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${docModel!.address}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${docModel!.phone}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              color: HexColor('FFE6D6'),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  15.0),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Patient',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        height: 1.3,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    '$patientNumber+',
                                                    style: const TextStyle(
                                                        fontSize: 25.0,
                                                        height: 1.3,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              color: HexColor('B5B9CE'),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  15.0),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Experience',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        height: 1.3,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    '${docModel!
                                                        .experience} year+',
                                                    style: const TextStyle(
                                                        fontSize: 25.0,
                                                        height: 1.3,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'About Doctor',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          height: 1.3,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Dr. ${docModel!
                                          .fullName} specializes in ${docModel!
                                          .specialization} , graduated from ${docModel!
                                          .university} University and I have a lot of certificates such as'
                                          '${docModel!.certificates}.',
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          height: 1.3,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(height: 15),
                                    ///////////////////////////////////////////////////////////////////////////////////////////////////
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20.0),
                                          color: Colors.teal[100]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DatePicker(
                                          DateTime.now(),
                                          initialSelectedDate: AppCubit
                                              .get(context)
                                              .dateSelectedValue,
                                          selectionColor: Colors.black,
                                          selectedTextColor: Colors.white,
                                          inactiveDates: AppCubit
                                              .get(context).dates,
                                          onDateChange: (date) {
                                            // New date selected
                                            AppCubit.get(context).timeSelectedValue =DateTime.parse("1990-01-01 00:00:00");
                                            AppCubit.get(context).onDateChange(
                                                date);
                                            //AppCubit.get(context).dateSelectedValue=date;
                                            //  DateFormat('EEEE, MMM d, yyyy').format(AppCubit.get(context).dateSelectedValue);
                                          },
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    SizedBox(
                                      height: 60,
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            timePicker(context, AppCubit
                                                .get(context)
                                                .times[index], docModel!.uId!),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            Container(),
                                        itemCount: AppCubit
                                            .get(context)
                                            .times
                                            .length,),
                                    ),
                                    defaultButton(function: () {
                                      print("yhe date is ${AppCubit.get(context).timeSelectedValue}");
                                      if(DateFormat('yyyy-MM-dd').format(AppCubit.get(context).timeSelectedValue)=='1990-01-01')
                                      {
                                        //00:00:0
                                        showToast(text: 'you should choose valid an appointment ', state: ToastStates.ERROR);
                                      }
                                      else {
                                        String date = DateFormat('yyyy-MM-dd')
                                            .format(AppCubit
                                            .get(context)
                                            .dateSelectedValue);
                                        print(date);
                                        String time = DateFormat('HH:mm:ss')
                                            .format(AppCubit
                                            .get(context)
                                            .timeSelectedValue);

                                        print(time);
                                        DateTime appoinment = DateTime.parse(
                                            '${date} ${time}');
                                        print(appoinment);
                                        AppCubit.get(context).patReservation(
                                          date: appoinment,
                                          doctorId: docModel!.uId!,
                                        );
                                        // print(formattedDate);
                                      } },
                                        text: 'Submit'),
                                    const SizedBox(height: 15),
                                    ConditionalBuilder(
                                      condition: AppCubit
                                          .get(context)
                                          .comments
                                          .isNotEmpty,
                                      builder: (context) =>
                                          ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  buildCommentItem(
                                                      AppCubit
                                                          .get(context)
                                                          .comments[index],
                                                      context),
                                              itemCount: AppCubit
                                                  .get(context)
                                                  .comments
                                                  .length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                  int index) =>
                                                  Container()),
                                      fallback: (context) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            ReviewScreen(
                                              ReciverUid: docModel!.uId!,
                                            ));
                                      },
                                      child: Text(
                                        'Please Write Your Review',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            height: 1.3,
                                            color: HexColor('4E51BF'),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              }
          );
      }
    );
  }
  Widget timePicker(BuildContext context,DateTime workTime,String docId) =>FutureBuilder(
      future: AppCubit.get(context).isExist(doctorId: docId,work:workTime),
      //stream: AppCubit.get(context).isExist(doctorId: docId,work:workTime),
      builder: (context,AsyncSnapshot<bool>snap) {
        print("the work time is $workTime");
        if(snap.data == null) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey[100]
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('HH:mm').format(workTime),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return InkWell(
          borderRadius:BorderRadius.circular(50),
          onTap: () {
            if(snap.data == false) {
              AppCubit.get(context).onTimeChange(workTime);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //color:HexColor('89CFF0'),
                //AppCubit.get(context).timeSelectedValue == workTime||
                // color: snap.data! ? Colors.black : Colors.teal[100],
                color:AppCubit.get(context).timeSelectedValue == workTime&&snap.data==false? Colors.black : snap.data!? Colors.grey[200] : Colors.teal[100],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('HH:mm').format(workTime),
                      style: TextStyle(
                        //color: snap.data!||AppCubit.get(context).timeSelectedValue==workTime ? Colors.black : Colors.white
                          color:AppCubit.get(context).timeSelectedValue==workTime&&snap.data==false ? Colors.white :snap.data!? Colors.grey[500] : Colors.black
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
  );
}
Widget buildCommentItem(CommentModel model, context) => FutureBuilder(
    future:AppCubit.get(context).getPatientData(model.senderId!),
    builder: (BuildContext context, AsyncSnapshot<PatientModel> snapshot){
      if(snapshot.data==null){
        if (kDebugMode) {
          print("gggggggggggggggggg");
        }
        return const LinearProgressIndicator();
      }else {
        return InkWell(
          onTap: () {
            //navigateTo(context,DoctorsInformation (docModel: model));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(snapshot.data!.image!),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.fullName!,
                        style: const TextStyle(
                            fontSize: 18.0,
                            height: 1.3,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: model.rate!,
                            itemBuilder: (context, index) =>
                                Icon(
                                  Icons.star,
                                  color: HexColor('4E51BF'),
                                ),
                            itemSize: 15.0,
                            unratedColor: Colors.grey,
                            itemCount: 5,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            getTime(model.createdAt),
                          ),
                        ],
                      ),
                      Text(
                        '${model.comment}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });


String getTime(var time) {
  //final DateFormat formatter = DateFormat('dd/MM/yyyy, hh:mm:ss aa');  your date format here
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(time);
}

