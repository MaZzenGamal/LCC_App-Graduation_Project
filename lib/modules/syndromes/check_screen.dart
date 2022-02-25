import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
List<String> _list = ['Yes', "No"];
class defaultListView extends StatefulWidget{
  late String title;
  late int number;
  //late bool isVisible;

  defaultListView({required this.title,required this.number});

  @override
  State<defaultListView> createState() => _defaultListViewState();
}

class _defaultListViewState extends State<defaultListView> {
  int? groubValue;
  bool isVisible=false;
  @override
  Widget build(BuildContext context) {

    return  Row(
      // start of list1
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          //style of the column that hold the name of list and icon and inner list
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: HexColor('4E51BF')),
                borderRadius:const BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              //this column hold the inner list and (tittle of list with icon)
              children: [
                Container(
                  //style of the row that hold the name of list and icon
                  width: double.infinity,
                  padding:const EdgeInsets.only(right: 10),
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //         color: HexColor('4E51BF')
                  //     ),
                  //     //borderRadius:const BorderRadius.all(Radius.circular(50))
                  // ),
                  height: 60,
                  constraints:const BoxConstraints(
                    minHeight: 45,
                    //minWidth: double.infinity,
                  ),
                  //alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isVisible=!isVisible;  //close or open the list
                      });
                    },
                    child: Row(
                      //Row that hold the name of list and icon
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(widget.title), //question
                          ),
                        ),
                        GestureDetector(
                          //icon of the list
                            onTap: () {
                              setState(() {
                                isVisible=!isVisible;  //close or open the list
                              });
                            },
                            child: Icon(isVisible
                                ? Icons.arrow_upward
                                : Icons
                                .arrow_downward)) // change the icon of the list
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: ListView.builder(
                    // yes or no insisde listview
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          activeColor: HexColor('4E51BF'),
                          title: Text(_list.elementAt(index)),
                          value: index,
                          groupValue: groubValue,
                          onChanged: (val) {
                            setState(() {
                              groubValue=val as int?;     //choose one radio button only
                            }
                            );
                          },
                        );
                      }),
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
