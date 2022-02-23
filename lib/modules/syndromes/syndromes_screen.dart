import 'package:flutter/material.dart';
import 'package:graduation_project/modules/syndromes/syndromes_details_screen.dart';

class SyndromesScreen extends StatefulWidget {
  const SyndromesScreen({Key? key}) : super(key: key);

  @override
  _SyndromesScreenState createState() => _SyndromesScreenState();
}

class _SyndromesScreenState extends State<SyndromesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        itemCount:data.length,
        itemBuilder: (BuildContext context,int index)=>EntryItem(data[index],),

      ),
    );
  }
}
