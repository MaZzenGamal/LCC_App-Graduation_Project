import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
   ChatDetailsScreen({Key? key}) : super(key: key);
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: AssetImage(
                  'assets/images/doctor.png'
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
                'DR.Mundo',
              style: TextStyle(
                fontSize: 15.0
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(
                Icons.call
              )),
          IconButton(onPressed: (){},
              icon: Icon(
               Icons.video_call
              )),
        ],
      ),
      body: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  IconButton(onPressed: (){},
                      icon: Icon(
                        Icons.add_circle
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'write your message...'
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){},
                      icon: Icon(
                        Icons.send
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
