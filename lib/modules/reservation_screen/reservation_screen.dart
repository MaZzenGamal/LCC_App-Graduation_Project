import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedValue = DateTime.now();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.teal[100]
            ) ,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
            ),
          ),
          const Divider(),
          Wrap(

            children: [

            ],
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
                itemBuilder: (context, index)=>timePicker(context,index),

                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Container(),
                itemCount: 20),
          ),
        ],
      ),
    );
  }
  int? selectedIndex;
  Widget timePicker(context,index) => InkWell(
    onTap: ()
    {
      setState(() {
        selectedIndex = index;
      });
    },
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color:HexColor('89CFF0'),
          color:selectedIndex == index ? Colors.black : Colors.teal[100],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0,top:10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$index',
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black
              ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
