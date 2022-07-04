import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/models/comment_model.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

import 'doctor_information_screen.dart';

class ReviewScreen extends StatelessWidget {
  String ReciverUid;
  double rateValue = 0;
  double oldValue = 0;
  int number = 0;
  var reviewcontroller = TextEditingController();
  var firebase = FirebaseFirestore.instance;
  late DoctorModel docModel;
  late CommentModel commModel;
  ReviewScreen({Key? key, required this.ReciverUid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //navigatorKey=navigateTo(context,DoctorsInformation() );
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:AppCubit.get(context).usermodel.type=='patient'? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Select your rate',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    unratedColor: HexColor('ffe9ce'),
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: HexColor('4E51BF'),
                    ),
                    onRatingUpdate: (rating) {
                      rateValue = rating;
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor('ffe9ce'),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: reviewcontroller,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your review...'),
                            ),
                          ),
                        ),
                        Container(
                          color: HexColor('4E51BF'),
                          child: IconButton(
                              onPressed: () async {
                                if (rateValue == 0 &&
                                    reviewcontroller.text.isEmpty) {
                                  showToast(
                                      text:
                                          'please write valid review and choose valid rate',
                                      state: ToastStates.ERROR);
                                  if (kDebugMode) {
                                    print(
                                        "please write valid review and choose valid rate");
                                  }
                                } else if (rateValue == 0 &&
                                    reviewcontroller.text.isNotEmpty) {
                                  showToast(
                                      text: 'please select valid rate',
                                      state: ToastStates.ERROR);
                                  if (kDebugMode) {
                                    print("please select valid rate");
                                  }
                                } else if (rateValue != 0 &&
                                    reviewcontroller.text.isEmpty) {
                                  showToast(
                                      text: 'please write valid review',
                                      state: ToastStates.ERROR);

                                  if (kDebugMode) {
                                    print("please write valid review");
                                  }
                                } else {
                                  if (kDebugMode) {
                                    print("thanks for your review");
                                  }
                                  try {
                                    exist = await checkExist(ReciverUid);
                                  } catch (c) {}
                                  if (exist) {
                                    if (kDebugMode) {
                                      print("the value of exist is $exist");
                                    }
                                    await firebase
                                        .collection('doctor')
                                        .doc(ReciverUid)
                                        .collection('comments')
                                        .doc(FirebaseAuth
                                        .instance.currentUser!.uid)
                                        .get()
                                        .then((value) {
                                      commModel =
                                          CommentModel.fromJson(
                                              value.data()!);
                                    });
                                    print(
                                        "the comment id is ${commModel
                                            .senderId}");
                                    await firebase
                                        .collection('doctor')
                                        .doc(ReciverUid)
                                        .get()
                                        .then((value) {
                                      docModel =
                                          DoctorModel.fromJson(
                                              value.data()!);
                                      oldValue = docModel.allRateValue!;
                                      number = docModel.allRateNumber!;
                                      print(
                                          "the old rate is ${commModel
                                              .rate}");
                                    });
                                    await firebase
                                        .collection('doctor')
                                        .doc(ReciverUid)
                                        .update({
                                      'allRateValue': (oldValue +
                                          rateValue -
                                          commModel.rate!),
                                      'rate': ((oldValue +
                                          rateValue -
                                          commModel.rate!) /
                                          (5 * (number))) *
                                          5
                                    });
                                  } else {
                                    print("document not existtttttttttttt");
                                    firebase
                                        .collection('doctor')
                                        .doc(ReciverUid)
                                        .get()
                                        .then((value) {
                                      docModel =
                                          DoctorModel.fromJson(value.data()!);
                                      double oldValue = docModel
                                          .allRateValue!;
                                      int number = docModel.allRateNumber!;
                                      firebase
                                          .collection('doctor')
                                          .doc(ReciverUid)
                                          .update({
                                        'allRateValue': oldValue + rateValue,
                                        'allRateNumber': number + 1,
                                        'rate': ((oldValue + rateValue) /
                                            (5 * (number + 1))) *
                                            5
                                      });
                                    });
                                  }
                                  AppCubit.get(context).sendComment(
                                      receiverId: ReciverUid,
                                      dateTime: DateTime.now(),
                                      text: reviewcontroller.text,
                                      rate: rateValue);
                                  showToast(
                                      text: 'thanks for your review',
                                      state: ToastStates.SUCCESS);
                                  navigateTo(context,DoctorsInformation (docModel:docModel));
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  myDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  BuildCondition(
                    condition: state is! GetCommentsLoadingState,
                    builder: (context) => BuildCondition(
                      condition: AppCubit.get(context).comments.isNotEmpty,
                      builder: (context) => SizedBox(
                        height: 400,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCommentItem(
                                AppCubit.get(context).comments[index], context),
                            itemCount: AppCubit.get(context).comments.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Container()),
                      ),
                      fallback: (context) => Center(
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '   "No comments, yet"\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                TextSpan(
                                    text: 'Be the first to write a review ',
                                    style: TextStyle(fontSize: 13.0)),
                              ]),
                        ),
                      ),
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  BuildCondition(
                    condition: state is! GetCommentsLoadingState,
                    builder: (context) => BuildCondition(
                      condition: AppCubit.get(context).comments.isNotEmpty,
                      builder: (context) => SizedBox(
                        height: 400,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCommentItem(
                                AppCubit.get(context).comments[index], context),
                            itemCount: AppCubit.get(context).comments.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                Container()),
                      ),
                      fallback: (context) => Center(
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '   "No comments, yet"\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                TextSpan(
                                    text: 'Be the first to write a review ',
                                    style: TextStyle(fontSize: 13.0)),
                              ]),
                        ),
                      ),
                    ),
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  late bool exist;
  Future<bool> checkExist(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('doctor')
          .doc(docID)
          .collection('comments')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
