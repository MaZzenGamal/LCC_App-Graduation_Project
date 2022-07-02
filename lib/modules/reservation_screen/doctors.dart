
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../models/patient_model.dart';
import '../../shared/components/components.dart';
import 'doctor_information_screen.dart';
class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getDoctors();
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: BuildCondition(
                condition: AppCubit.get(context).alldoctor.isNotEmpty,
                builder: (context)=>ListView.separated(
                  physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildDoctorItem(AppCubit.get(context).alldoctor[index],context),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: AppCubit.get(context).alldoctor.length),
                fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
              ),
            );
          },
        );
      }
    );
  }
}
final List<Color> colors = <Color>[HexColor('c6cefb'), HexColor('ff92a4'),HexColor('ffe9ce')];
Widget buildDoctorItem(DoctorModel model,context) => InkWell(
  onTap: ()
  {
    AppCubit.get(context).dateSelectedValue=DateTime.now().weekday==5?DateTime.now().add(const Duration(days: 1)):DateTime.now();
    AppCubit.get(context).timeSelectedValue=DateTime.parse("1990-01-01 00:00:00");
    navigateTo(context,DoctorsInformation (docModel: model));
  } ,
  child:Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color:HexColor('89CFF0'),
        color: HexColor('C0C1E8').withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: HexColor('C0C1E8').withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
            offset:const Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0,top:10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(
                '${model.image}',
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
                      'Dr.${model.fullName}',
                      style: const TextStyle(fontSize: 18.0, height: 1.3,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${model.specialization}',
                      style: const TextStyle(fontSize: 18.0, height: 1.3),
                    ),
                    Text(
                      '${model.phone}',
                      style: const TextStyle(fontSize: 18.0, height: 1.3,color: Colors.grey),
                    ),
                    RatingBarIndicator(
                     rating:model.rate!,
                      itemBuilder: (context,index)=>Icon(
                        Icons.star,
                        color: HexColor('4E51BF'),
                      ),
                      itemSize :23.0,
                      unratedColor:Colors.grey[200],
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
      ),
    ),
  ),
);
/*Future<DoctorModel>getphoto(String uid)async{
  FirebaseFirestore.instance.collection('doctor').doc(uid)
      .snapshots().listen((event) {
    docModel = PatientModel.fromJson(event.data()!);
  });
  return patModel;

}*/