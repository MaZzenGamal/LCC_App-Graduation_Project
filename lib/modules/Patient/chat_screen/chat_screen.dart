import 'package:flutter/material.dart';
import 'package:graduation_project/modules/Patient/chat_screen/chat_details_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(
          'Chat'
        ),
      ),
      body: InkWell(
        onTap: ()
        {
          navigateTo(context, ChatDetailsScreen());
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(
                'assets/images/doctor.png'
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'DR.Mundo'
            )
          ],
        ),
      ),
    );
  }
}
