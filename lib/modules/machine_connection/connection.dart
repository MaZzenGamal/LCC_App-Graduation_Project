import 'package:flutter/material.dart';
import 'package:graduation_project/modules/machine_connection/colon/colon_interface.dart';
import 'package:graduation_project/modules/machine_connection/lungs/interface.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:hexcolor/hexcolor.dart';


class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(10);
    int currentTape = 0;
    final _kTabs = <Tab>[
      const Tab(text: 'Lung cancer'),
      const Tab(text: 'Colon cancer'),
    ];
    return DefaultTabController(
      length:  _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading:const Icon(
            Icons.search,
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
              currentTape=index;
            },
            padding: const EdgeInsets.all(10.0),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            LungInterface(),
            ColonInterface(),
          ],
        ),
      ),
    );
  }
}
