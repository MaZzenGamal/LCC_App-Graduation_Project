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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10.0),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                  horizontal: 10.0),
                  child: Text(
                      'SUUUIIIIII'),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    bottomStart: Radius.circular(10.0),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                  horizontal: 10.0),
                  child: Text(
                      'SUUUUUUUUUUIIII'),
                ),
              ),
            ),
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
      ),
    );
  }

  Widget buildMessages() =>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0),
        child: Text(
            'shiiiiiiiiiiiiiiiiiit'),
      ),
    ),
  );
  Widget buildMyMessages() =>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0),
        child: Text(
            'shiiiiiiiiiiiiiiiiiit'),
      ),
    ),
  );
}
