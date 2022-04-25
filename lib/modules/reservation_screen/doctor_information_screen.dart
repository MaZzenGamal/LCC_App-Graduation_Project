import 'package:conditional_builder/conditional_builder.dart';
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
  DoctorsInformation({Key? key, this.docModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //navigatorKey=navigateTo(context,DoctorsInformation() );
    return Builder(
      builder: (context) {
        AppCubit.get(context).getComment( receiverId:docModel!.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
          },
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
                          image: DecorationImage(
                              image: NetworkImage("${docModel!.image!}"),
                              //image: NetworkImage("https://picsum.photos/id/237/200/300"),
                              fit: BoxFit.cover),
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
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor('FFE6D6'),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Patient',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          height: 1.3,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '$patientNumber+',
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          height: 1.3,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
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
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor('B5B9CE'),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Exprience',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          height: 1.3,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${docModel!.exprience} year+',
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          height: 1.3,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
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
                            fontSize: 20.0, height: 1.3, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Dr. ${docModel!.fullName} specializes in ${docModel!.specialization} , graduated from ${docModel!.university} University and I have a lot of certificates such as'
                        '${docModel!.certificates}.',
                        style: const TextStyle(
                            fontSize: 18.0, height: 1.3, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      ConditionalBuilder(
                        condition: AppCubit.get(context).comments.isNotEmpty,
                        builder: (context) => ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCommentItem(
                                AppCubit.get(context).comments[index],AppCubit.get(context).patModel, context),
                            itemCount: AppCubit.get(context).comments.length,
                            separatorBuilder: (BuildContext context, int index) =>
                                Container()),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          onTap: ()
                          {
                            navigateTo(context,ReviewScreen(ReciverUid: docModel!.uId!,));
                          } ,
                          child:  Text(
                            'Please Write Your Review',
                            style: TextStyle(
                                fontSize: 17.0,
                                height: 1.3,
                                color: HexColor('4E51BF'),
                                fontWeight: FontWeight.bold),
                          ),),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}

Widget buildCommentItem(CommentModel cModel,PatientModel patModel, context) => InkWell(
      onTap: () {
        //navigateTo(context,DoctorsInformation (docModel: model));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage: NetworkImage(
              '${patModel.image}',
            ),
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
                    '${patModel.fullName}',
                    style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.3,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: cModel.rate!,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: HexColor('4E51BF'),
                        ),
                        itemSize: 15.0,
                        unratedColor: Colors.grey,
                        itemCount: 5,
                        direction: Axis.horizontal,
                        /* minRating:1,
                  initialRating:3.6 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures:true,
                  itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.amber),
                  onRatingUpdate: (rating)=>{}*/
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getTime(cModel.createdAt),
                      ),
                    ],
                  ),
                  Text(
                    '${cModel.message}',
                  ),
                  /*Row(
                children: [
                  Text(
                    '${model.fullName}',
                    style: TextStyle(fontSize: 18.0, height: 1.3),
                  ),
                ],
              ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
String getTime(var time) {
  //final DateFormat formatter = DateFormat('dd/MM/yyyy, hh:mm:ss aa');  your date format here
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  var date = time.toDate();
  return formatter.format(date);
}
