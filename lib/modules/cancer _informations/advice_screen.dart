import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title:const Text(
            'How to face it !!'
        ),
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 190.0,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset:const Offset(0,5 ), // changes position of shadow
                          ),
                        ],
                        image:const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/cancer advice.jpg')
                        ))),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Can’t catch your breath?',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Keep in mind that stress and anxiety make it worse. Take slow, steady, deep breaths. Fix your mind on something that will relax and calm you.You can also try to sleep with your head raised on pillows. And light exercise may also do the trick.'
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Protect Your Lungs :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                              'Make sure your lungs arn\'t being stressed any more than they need to be.If you smoke, quit smoking. Avoid second hand smoke and going outside when the air quality is poor.Ask people not to smoke near you at work and at home. Avoid social activities that will expose you to secondhand smoke.Quitting smoking makes a positive difference in your risk for lung cancer and ability to heal after lung cancer treatment.'
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Take Care of Your Body :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Your body needs all the support it can get so you can heal properly and fight lung cancer...'
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Text(
                        '...Stress can weaken your immune system and take other tolls on your body. Using lung cancer support resources and some complementary medicine treatments can help reduce stress. Talk with you lung cancer care team about ways to cope with the stress of lung cancer...'
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Text(
                        '...Conserving energy can help you fight fatigue. Make sure you get the appropriate amount of rest, not too much or too little. Planning ahead, spacing tasks out andasking for help also will help you feel less tired...'
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Text(
                          '...Physical activity will help you feel better physically and mentally. Even small amounts of activity can help.'
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not sure what to eat ?',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'There isn’t a special lung cancer diet. And despite what you may have heard, there’s no scientific evidence to support the alkalineor mushroom diet, says Aaron Mansfield, MD, assistant professor in the oncology division at the Mayo Clinic in Rochester, MN.Instead, he suggests common-sense stuff like keeping your weight in check.Instead, he suggests common-sense stuff like keeping your weight in check.Need to gain weight? Bulk up your diet with a supplement drink that has nutrients and extra calories. Want to lose a few pounds?Work with your doctor to create a weight loss plan you can stick to.'
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use Your Support System :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Friends, family and healthcare professionals are invaluable resources during this time. Most people you know want to help,they just don\'t know how. Don\'t be afraid to ask for support from those around you. Always talk openly with your healthcare team.'
                          )
                        ],
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
