
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/cancer%20_informations/advice_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/cancer_types_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/motivation_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/risk_factor_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

class CancerInfoScreen extends StatefulWidget {
  const CancerInfoScreen({Key? key}) : super(key: key);

  @override
  _CancerInfoScreenState createState() => _CancerInfoScreenState();
}
var formKey = GlobalKey<FormState>();
class _CancerInfoScreenState extends State<CancerInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Lung cancer Info...'
        ),
      ),
      body:Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/test5.png'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Form(
            key:formKey ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: 190.0,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 8,
                              offset:const Offset(0,5 ), // changes position of shadow
                            ),
                          ],
                          shape: BoxShape.rectangle,
                          image:const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/lung cancer.jpg')
                          ))),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        '- Lung cancer is cancer that forms in tissues of the lung, usually in the cells that line the air passages. It is the leading cause of cancer death in both men and women.',

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        '- Lung cancer is the leading cause of cancer death and the second most diagnosed cancer in both men and women in the United States.'
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        '- After increasing for decades, lung cancer rates are decreasing nationally, as fewer people smoke cigarettes and as lung cancer treatments improve.'
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        '- Lung cancer begins in the lungs and may spread to lymph nodes or other organs in the body, such as the brain. Cancer from other organs also mayspread to the lungs. When cancer cells spread from one organ to another, they are called metastases.'
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:GestureDetector(
                      onTap: ()
                      {
                        navigateTo(context,const CancerTypesScreen());
                      },
                      child: Row(
                        children: [
                         const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text(
                              '- Types of lung cancer......'
                            ),
                          ),
                         const Spacer(),
                          defaultTextButton(function: ()
                          {
                            navigateTo(context,const CancerTypesScreen());
                          },
                              text: 'more>>')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:GestureDetector(
                      onTap: ()
                      {
                        navigateTo(context,const CancerTypesScreen());
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text(
                                '- Risk factors......'
                            ),
                          ),
                          const Spacer(),
                          defaultTextButton(function: ()
                          {
                            navigateTo(context,const RiskFactorScreen());
                          },
                              text: 'more>>')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child:GestureDetector(
                      onTap: ()
                      {
                        navigateTo(context,const MotivationScreen());
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text(
                                '- Can’t catch your breath?'
                            ),
                          ),
                          const Spacer(),
                          defaultTextButton(function: ()
                          {
                            navigateTo(context,const AdviceScreen());
                          },
                              text: 'more>>')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
