import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'check_screen.dart';

class SyndromesScreen extends StatefulWidget {
  @override
  _SyndromesScreenState createState() => _SyndromesScreenState();
}

var age = 40;
Map<dynamic,String>answer={0:"age",1:'',2:'',3:'',4:'',5:'',6:'',7:'',8:'',9:'',10:'',11:'',12:''};

class _SyndromesScreenState extends State<SyndromesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: [
              defaultListView(
                title: 'Are You Smoking?',
                number:1,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are Your Fingers Yellow?',
                number:2,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Anxiety?',
                number:3,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Feeling Peer Pressure',
                number:4,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Any Chronic Disease?',
                number:5,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Any Fatigue?',
                number:6,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Allergy?',
                number:7,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Wheezing?',
                number:8,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Drinking Alcohol?',
                number:9,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Coughing?',
                number:10,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Swallowing Difficulty?',
                number:11,
              ),
              const SizedBox(
                height:20,
              ),
              defaultListView(
                title: 'Are You Suffering From Chest Pain?',
                number:12,
              ),
              const SizedBox(
                height:20,
              ),
              Container(
                //style of the row that hold the name of list and icon
                width: double.infinity,
                padding:const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color:  HexColor('4E51BF'),
                    border: Border.all(
                        color: HexColor('4E51BF')
                    ),
                    borderRadius:const BorderRadius.all(Radius.circular(20))),

                child: TextButton(onPressed: () {

                }, child:const Text('SEND',
                style:TextStyle(
                  color: Colors.white
                ),),

                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
