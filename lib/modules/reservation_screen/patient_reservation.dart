import 'package:buildcondition/buildcondition.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/reservation_model.dart';
import 'package:graduation_project/modules/reservation_screen/doctor_information_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../../models/doctor_model.dart';
import '../../shared/components/components.dart';


class ShowPatientReservation extends StatelessWidget {
  ShowPatientReservation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(10);
    final _kTabs = <Tab>[
      const Tab(text: 'Upcoming'),
      const Tab(text: 'Complete'),
    ];
    return FutureBuilder(
        future: AppCubit.get(context).showReservation(),
        builder: (context, _) {
          return BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return DefaultTabController(
                  length: _kTabs.length,
                  child: Scaffold(
                      appBar: AppBar(
                        leading:const Icon(
                          Icons.swipe,
                          color: Colors.grey,
                        ),
                        title: const Text(
                          'swipe for edit or cancel',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              ),
                        ),
                        bottom: TabBar(
                          tabs: _kTabs,
                          unselectedLabelColor: Colors.grey,
                          indicator: ShapeDecoration(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: radius, topLeft: radius)),
                              color: HexColor('ff92a4')
                          ),
                          labelColor:HexColor('FFE6D6'),
                          onTap:(index){
                            AppCubit.get(context).currentTape=index;
                          },
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TabBarView(
                          children: <Widget>[
                            ConditionalBuilder(
                              condition: state is! GetPatUpComingReservationLoadingState ,
                              builder: (context) =>BuildCondition(
                                condition:AppCubit.get(context).upcomingReservations.isNotEmpty,
                                builder:(context)=> ListView.separated(
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: showReservation(context, AppCubit.get(context).upcomingReservations[index], index),
                                  ),
                                  itemCount: AppCubit.get(context).upcomingReservations.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) => const SizedBox(height: 10.0,),
                                ),
                                fallback:(context)=> const Center(child:  Text('You don\'t have upcomming reservations ',
                                  style: TextStyle(color: Colors.grey,fontSize: 15.0),)),
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                            ConditionalBuilder(
                              condition: state is! GetPatCompletedReservationLoadingState ,
                              builder: (context) =>BuildCondition(
                                condition: AppCubit.get(context).completeReservations.isNotEmpty ,
                                builder:(context) => ListView.separated(
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: showReservation(context, AppCubit.get(context).completeReservations[index],index),),
                                  itemCount: AppCubit.get(context).completeReservations.length,
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0,),
                                ),
                                fallback:(context) => const Center(child:  Text('You don\'t have completed reservations ',
                                  style: TextStyle(color: Colors.grey,fontSize: 15.0),)),
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            )
                          ],
                        ),
                      )),
                );
              });
        });
  }
  bool isDisable=true;
  Widget showReservation(
      BuildContext context, ReservationModel resvModel, int index) =>
      FutureBuilder(
          future: AppCubit.get(context).getDoctorData(uid: resvModel.doctorId!),
          builder: (context, AsyncSnapshot<DoctorModel> snap) {
            if (snap.data == null) {
              if (kDebugMode) {
                print("gggggggggggggggggg");
              }
              return const LinearProgressIndicator();
            } else {
              if(AppCubit.get(context).currentTape==1){
                isDisable=false;
              }
              else
                {
                  isDisable=true;
                }
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color:HexColor('89CFF0'),
                    color: HexColor('C0C1E8').withOpacity(0.6),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('C0C1E8').withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        offset:const Offset(0, 7), // changes position of shadow
                      ),]
                ),
                child: isDisable==true?Dismissible(
                  key: UniqueKey(),
                  onDismissed:(DismissDirection dir) {
                    dir==DismissDirection.startToEnd?
                      AppCubit.get(context)
                          .removeReservation(index: index, model: resvModel):
                    AppCubit.get(context).reservationId=resvModel.reservationId!;
                    navigateTo(context,DoctorsInformation(docModel:snap.data ));
                  },
                  background:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.edit),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(snap.data!.image!),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr.${snap.data!.fullName!}',
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    height: 1.3,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snap.data!.specialization!,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    height: 1.3,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 1.3),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_sharp,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('EEEE, MMM d')
                                            .format(resvModel.date!),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('hh:mm')
                                            .format(resvModel.date!),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(snap.data!.image!),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr.${snap.data!.fullName!}',
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  height: 1.3,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snap.data!.specialization!,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  height: 1.3,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 1.3),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_sharp,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat('EEEE, MMM d')
                                          .format(resvModel.date!),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      DateFormat('hh:mm')
                                          .format(resvModel.date!),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),

              );
            }
          });
}
/*import 'package:flutter/material.dart';

class ListSwipeToDismissExample extends StatefulWidget {
  const ListSwipeToDismissExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListSwipeToDismissExampleState();
  }
}

class _ListSwipeToDismissExampleState extends State<ListSwipeToDismissExample> {
  final _items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final String item = _items[index];*/
// Each Dismissible must contain a Key. Keys allow Flutter to uniquely
// identify Widgets.
/* return Dismissible(
            key: Key(item),
            // We also need to provide a function that tells our app what to do
            // after an item has been swiped away.
            onDismissed: (DismissDirection dir) {
              setState(() => this._items.removeAt(index));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    dir == DismissDirection.startToEnd
                        ? '$item removed.'
                        : '$item liked.',
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() => this._items.insert(index, item));
                    },
                  ),
                ),
              );
            },*/
// Show a red background as the item is swiped away
/* background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete),
            ),*/
// Background when swipping from right to left
/* secondaryBackground: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.thumb_up),
            ),
            child: ListTile(
              title: Center(child: Text(_items[index])),
            ),
          );
        },
      ),
    );
  }
}*/
/////ListTile(
//                           title: Center(child: Text('${resvModel.doctorId!}\n${resvModel.patientId!}'))
//                         ),
/*
:ConditionalBuilder(
                    condition: AppCubit.get(context).upcomingReservations.isNotEmpty,
                    builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => showReservation(context,
                          AppCubit.get(context).upcomingReservations[index], index),
                      itemCount: AppCubit.get(context).upcomingReservations.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(),
                    ),
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  )
 */
