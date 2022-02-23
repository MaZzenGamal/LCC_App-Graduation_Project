import 'package:flutter/material.dart';

class Entry {
  Entry(this.title,[this.children = const <Entry>[]]);
  final String title;
  int radioValue = 0;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Are You Smoking?',  // هل تدخن
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are Your Fingers Yellow?',  //هل اصابعك صفراء
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Anxiety?',  //هل انت قلق
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Feeling Peer Pressure>',  //   احساس الإنسان انه مضغوط ولازم يعمل الحاجه دي
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Any Chronic Disease?',  //هل  تعاني من اي مرض مزمن
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Any Fatigue?',  //هل  تعاني من اي تعب
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Allergy?',  //هل  تعاني من الحساسيه
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Wheezing?',  //ده صوت بيطلع من الصدر لو فيه حاجه ساده النفس
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Drinking Alcohol?',  //هل تشرب كحول
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Coughing?', //هل تعاني من السعال
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Swallowing Difficulty?', //هل تعاني من صعوبه في البلع
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
  Entry(
    'Are You Suffering From Chest Pain?', //هل تعاني من الم في الصدر
    <Entry>[
      Entry('Yes'),
      Entry('No'),
    ],
  ),
];
class EntryItem extends StatefulWidget{
  const EntryItem(this.entry);
  final Entry entry;
  @override
  _EntryItemState createState() {
    return  _EntryItemState(entry);
  }
}

class _EntryItemState extends State<EntryItem> {
  Entry? entry;

  _EntryItemState(Entry entry) {
    this.entry;
  }
  void handleRadioValueChanged(value, Entry root) {
    setState(() {
      root.radioValue = value;
    });
  }

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return Column(
        children: [
          ListTile(
            title:Text(root.title),
            leading: Radio(
                value: 0,
                groupValue:root.radioValue,
                onChanged: (value) => handleRadioValueChanged(value, root)),
          ),
          ListTile(
            leading: Radio(
                value: 1,
                groupValue:root.radioValue,
                onChanged: (value) => handleRadioValueChanged(value, root)),
          ),
        ],
      );

    }
    else {               // اي خاصيه للعنصر هنحطها هنا
      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border:Border.all(color:Colors.green)
        ),
        child: ExpansionTile(
          key: PageStorageKey<Entry>(root),
          title: Text(root.title),
          children: root.children.map<Widget>(_buildTiles).toList(),
        ),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.entry);
  }
  Widget buildRadio(Entry root) {
    return  Align(
        alignment: const Alignment(0.0, -0.2),
        child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     Radio<int>(
                        value: 0,
                        groupValue: root.radioValue,
                        onChanged: (value)=>handleRadioValueChanged(value,root)
                    ),

                  ]
              ),
              // Disabled radio buttons
            ]
        )
    );   }
}
