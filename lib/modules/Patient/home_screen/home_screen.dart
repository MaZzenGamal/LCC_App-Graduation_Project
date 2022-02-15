import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:numberpicker/numberpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum condition { patient, doctor }
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _HomeScreenState extends State<HomeScreen> {
  condition? val = condition.patient;
  condition? val2 = condition.doctor;
  WhyFarther _selection = WhyFarther.harder;
  int age = 20;
  createAlertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('select your age'),
            content: NumberPicker(
                minValue: 10,
                maxValue: 100,
                value: age ,

                onChanged: (value){
                  setState((){
                    age=value;
                  });
                }),
            actions: [

            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                title:const Text('Patient'),
                leading: Radio<condition>(
                  value: condition.patient,
                  groupValue: val2,
                  onChanged: (condition? value) {
                    setState(() {
                      val2 = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title:const Text('Doctor'),
                leading: Radio<condition>(
                  value: condition.doctor,
                  groupValue: val2,
                  onChanged: (condition? value) {
                    setState(() {
                      val2 = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
        /*PopupMenuButton<WhyFarther>(
          onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
            const PopupMenuItem<WhyFarther>(
              value: WhyFarther.harder,
              child: Text('Working a lot harder'),
            ),
            const PopupMenuItem<WhyFarther>(
              value: WhyFarther.smarter,
              child: Text('Being a lot smarter'),
            ),
            const PopupMenuItem<WhyFarther>(
              value: WhyFarther.selfStarter,
              child: Text('Being a self-starter'),
            ),
            const PopupMenuItem<WhyFarther>(
              value: WhyFarther.tradingCharter,
              child: Text('Placed in charge of trading charter'),
            ),
          ],
        ),*/
        /*NumberPicker(
            minValue: 10,
            maxValue: 100,
            value: age ,
            onChanged: (value){
              setState((){
                age=value;
              });
            }),*/
        Text(
          'age: ${age}'
        ),
        AlertDialog(
          title: Text('select your age'),
          content: NumberPicker(
              minValue: 10,
              maxValue: 100,
              value: age ,
              onChanged: (value){
                setState((){
                  age=value;
                });
              }),
        ),
        defaultButton(function: (){
          createAlertDialog(context);
        },
            text: 'show')
    ],
    );
  }
}
