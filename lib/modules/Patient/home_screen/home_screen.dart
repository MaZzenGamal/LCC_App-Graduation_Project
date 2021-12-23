import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum condition { patient, doctor }

class _HomeScreenState extends State<HomeScreen> {
  condition? val = condition.patient;
  condition? val2 = condition.doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
