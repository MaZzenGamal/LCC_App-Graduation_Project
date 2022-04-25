import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/models/comment_model.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class ReviewScreen extends StatelessWidget {
  String ReciverUid;
  late double rateValue = 0;
  var reviewcontroller = TextEditingController();
  var firebase = FirebaseFirestore.instance;
  var uID = CacheHelper.getData(key: 'uId');
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
               title: InkWell(
                 onTap: () async {
                   if (rateValue == 0 && reviewcontroller.text.isNotEmpty) {
                     showToast(
                         text: 'please select valid rate',
                         state: ToastStates.ERROR);
                     if (kDebugMode) {
                       print("please select valid rate");
                     }
                   } else if (rateValue != 0 && reviewcontroller.text.isEmpty) {
                     showToast(
                         text: 'please write valid review',
                         state: ToastStates.ERROR);

                     if (kDebugMode) {
                       print("please write valid review");
                     }
                   } else if (rateValue == 0 && reviewcontroller.text.isEmpty) {
                     showToast(
                         text: 'please write valid review and choose valid rate',
                         state: ToastStates.ERROR);
                     if (kDebugMode) {
                       print("please write valid review and choose valid rate");
                     }
                   } else {
                     showToast(
                         text: 'thanks for your review',
                         state: ToastStates.SUCCESS);
                     if (kDebugMode) {
                       print("thanks for your review");
                     }
                     ;
                     bool exist = await checkExist(ReciverUid);
                     if (kDebugMode) {
                       print("the value of exist is $exist");
                     }
                     await firebase
                         .collection('doctor')
                         .doc(ReciverUid)
                         .collection('comments')
                         .doc(uID)
                         .get()
                         .then((doc) {
                       if (doc.exists) {
                         print("document exit");
                         firebase.collection('doctor').doc(ReciverUid).collection('comments').doc(uID).get().then((value) {
                           commModel = CommentModel.fromJson(value.data()!);
                           firebase
                               .collection('doctor')
                               .doc(ReciverUid)
                               .get()
                               .then((value) {
                             docModel = DoctorModel.fromJson(value.data()!);
                             double oldValue = docModel.allRateValue!;
                             int number = docModel.allRateNumber!;
                             print("the old rate is ${commModel.rate}");
                             firebase.collection('doctor').doc(ReciverUid).update({
                               'allRateValue': (oldValue + rateValue-commModel.rate!),
                               'rate': ((oldValue + rateValue-commModel.rate!) / (5 * (number))) * 5
                             });
                           });
                         });
                       }
                       else {
                         print("document not existtttttttttttt");
                         firebase
                             .collection('doctor')
                             .doc(ReciverUid)
                             .get()
                             .then((value) {
                           docModel = DoctorModel.fromJson(value.data()!);
                           double oldValue = docModel.allRateValue!;
                           int number = docModel.allRateNumber!;
                           firebase.collection('doctor').doc(ReciverUid).update({
                             'allRateValue': oldValue + rateValue,
                             'allRateNumber':number+1,
                             'rate': ((oldValue + rateValue) / (5 * (number+1))) * 5
                           });
                         });
                       }
                     });
                     AppCubit.get(context).sendComment(
                         receiverId: ReciverUid,
                         dateTime: DateTime.now(),
                         text: reviewcontroller.text,
                         rate: rateValue);
                   }
                 },
                 child: Container(
                   alignment: Alignment.topRight,
                   child: Text(
                     "POST",
                     style: TextStyle(
                         fontSize: 18.0,
                         height: 1.3,
                         color: HexColor('655FB0'),
                         fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
             ),
             body: Container(
               constraints:const BoxConstraints.expand(),
               decoration:const BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage('assets/images/red.jpg'),
                       fit: BoxFit.cover)),
               child: SingleChildScrollView(
                 child: Padding(
                   padding:
                       const EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text('Choose Your Rate',
                           style: TextStyle(
                               fontSize: 18.0,
                               height: 1.3,
                               color: Colors.black,
                               fontWeight: FontWeight.bold)),
                       const SizedBox(
                         height: 15,
                       ),
                       RatingBar.builder(
                         initialRating: 0,
                         direction: Axis.horizontal,
                         allowHalfRating: true,
                         unratedColor: Colors.grey,
                         itemCount: 5,
                         itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                         itemBuilder: (context, _) => Icon(
                           Icons.star,
                           color: HexColor('655FB0'),
                         ),
                         onRatingUpdate: (rating) {
                           rateValue = rating;
                           if (kDebugMode) {
                             print(rating);
                           }
                         },
                       ),
                       const SizedBox(
                         height: 30,
                       ),
                       const Text('Write Your Review',
                           style: TextStyle(
                               fontSize: 18.0,
                               height: 1.3,
                               color: Colors.black,
                               fontWeight: FontWeight.bold)),
                       const SizedBox(
                         height: 30,
                       ),
                       TextFormField(
                         controller: reviewcontroller,
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderSide:
                                 BorderSide(color: HexColor('4E51BF'), width: 2.0),
                             borderRadius: BorderRadius.circular(50.0),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide:
                                 BorderSide(color: HexColor('4E51BF'), width: 2.0),
                             borderRadius: BorderRadius.circular(50.0),
                           ),
                         ),
                       ),
                     ],
                   ),
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
          .doc(CacheHelper.getData(key: 'uId'))
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
