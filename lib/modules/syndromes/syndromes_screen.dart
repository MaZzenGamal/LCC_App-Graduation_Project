import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'check_screen.dart';

class SyndromesScreen extends StatefulWidget {
  @override
  _SyndromesScreenState createState() => _SyndromesScreenState();
}

var age = 40;

class _SyndromesScreenState extends State<SyndromesScreen> {
  Map<dynamic, dynamic> answers = {0: age};
  bool show1 = false,
      show2 = false,
      show3 = false,
      show4 = false,
      show5 = false,
      show6 = false,
      show7 = false,
      show8 = false,
      show9 = false,
      show10 = false,
      show11 = false,
      show12 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: [
              defaultListView(
                title: 'Are You Smoking?',
                onAnswer: (answer) => answers[2] = answer,
              ),
              Visibility(visible:show1,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are Your Fingers Yellow?',
                onAnswer: (answer) => answers[2] = answer,
              ),
              Visibility(visible:show2,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Anxiety?',
                onAnswer: (answer) => answers[3] = answer,
              ),
              Visibility(visible:show3,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Feeling Peer Pressure',
                onAnswer: (answer) => answers[4] = answer,
              ),
              Visibility(visible:show4,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Any Chronic Disease?',
                onAnswer: (answer) => answers[5] = answer,
              ),
              Visibility(visible:show5,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Any Fatigue?',
                onAnswer: (answer) => answers[6] = answer,
              ),
              Visibility(visible:show6,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Allergy?',
                onAnswer: (answer) => answers[7] = answer,
              ),
              Visibility(visible:show7,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Wheezing?',
                onAnswer: (answer) => answers[8] = answer,
              ),
              Visibility(visible:show8,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Drinking Alcohol?',
                onAnswer: (answer) => answers[9] = answer,
              ),
              Visibility(visible:show9,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Coughing?',
                onAnswer: (answer) => answers[10] = answer,
              ),
              Visibility(visible:show10,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Swallowing Difficulty?',
                onAnswer: (answer) => answers[11] = answer,
              ),
              Visibility(visible:show11,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              defaultListView(
                title: 'Are You Suffering From Chest Pain?',
                onAnswer: (answer) => answers[12] = answer,
              ),
              Visibility(visible:show12,child: Container(width:double.infinity,child: Text("please answer this question",textAlign: TextAlign.left,style:TextStyle(color:Colors.red)))),
              const SizedBox(
                height: 20,
              ),
              Container(
                //style of the row that hold the name of list and icon
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: HexColor('4E51BF'),
                    border: Border.all(color: HexColor('4E51BF')),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),

                child: TextButton(
                  onPressed: () {
                    if (answers[1] == null)
                      setState(() {
                        show1 = true;
                      });
                    else {
                      setState(() {
                        show1 = false;
                      });
                    }
                    if (answers[2] == null)
                      setState(() {
                        show2 = true;
                      });
                    else {
                      setState(() {
                        show2 = false;
                      });
                    }
                    if (answers[3] == null)
                      setState(() {
                        show3 = true;
                      });
                    else {
                      setState(() {
                        show3 = false;
                      });
                    }
                    if (answers[4] == null)
                      setState(() {
                        show4 = true;
                      });
                    else {
                      setState(() {
                        show4 = false;
                      });
                    }
                    if (answers[5] == null)
                      setState(() {
                        show5 = true;
                      });
                    else {
                      setState(() {
                        show5 = false;
                      });
                    }
                    if (answers[6] == null)
                      setState(() {
                        show6 = true;
                      });
                    else {
                      setState(() {
                        show6 = false;
                      });
                    }
                    if (answers[7] == null)
                      setState(() {
                        show7 = true;
                      });
                    else {
                      setState(() {
                        show7 = false;
                      });
                    }
                    if (answers[8] == null)
                      setState(() {
                        show8 = true;
                      });
                    else {
                      setState(() {
                        show8 = false;
                      });
                    }
                    if (answers[9] == null)
                      setState(() {
                        show9 = true;
                      });
                    else {
                      setState(() {
                        show9 = false;
                      });
                    }
                    if (answers[10] == null)
                      setState(() {
                        show10 = true;
                      });
                    else {
                      setState(() {
                        show10 = false;
                      });
                    }
                    if (answers[11] == null)
                      setState(() {
                        show11 = true;
                      });
                    else {
                      setState(() {
                        show11 = false;
                      });
                    }
                    if (answers[12] == null)
                      setState(() {
                        show12 = true;
                      });
                    else {
                      setState(() {
                        show12 = false;
                      });
                    }
                  },
                  child: const Text(
                    'SEND',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
