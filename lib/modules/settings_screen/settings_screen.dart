import 'package:flutter/material.dart';
import 'package:graduation_project/modules/cancer%20_informations/cancer_info_screen.dart';
import 'package:graduation_project/modules/language/languages_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          physics:BouncingScrollPhysics() ,
          itemBuilder: (context,index)=>InkWell(
            child: Container(
              height: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cancer information',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            onTap: (){
              navigateTo(context, CancerInfoScreen());
            },
          ),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount: 1),
      );
  }
}
