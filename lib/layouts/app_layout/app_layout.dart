import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/layouts/patient_layout/patient_layout.dart';
import 'package:graduation_project/shared/components/components.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
          body: Container(
            constraints:const BoxConstraints.expand(),
            decoration:const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/dark.png'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Use as :',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent
                )),
               const SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: (){},
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    child: Column(
                      children:  [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration:const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/doc.png'),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                       const Text(
                          'Doctor',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    color: Colors.teal,
                  ),
                ),
               const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: (){
                    navigateTo(context, PatientLayout());
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    child: Column(
                      children:  [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration:const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/patient.png'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        const Text(
                          'Patient',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
