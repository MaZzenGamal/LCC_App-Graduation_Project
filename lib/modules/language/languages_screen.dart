import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/components.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                height: 80.0,
                child: Row(
                  children: [
                    Text(
                        'English',
                      style: TextStyle(
                        fontSize: 20.0
                      ),

                    ),
                    Spacer(),
                    Icon(
                      Icons.add_circle_outline
                    )
                  ],
                ),
              ),
            ),
            myDivider(),
            InkWell(
              onTap: (){},
              child: Container(
                height: 80.0,
                child: Row(
                  children: [
                    Text(
                      'Arabic',
                      style: TextStyle(
                          fontSize: 20.0
                      ),

                    ),
                    Spacer(),
                    Icon(
                        Icons.add_circle_outline
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
