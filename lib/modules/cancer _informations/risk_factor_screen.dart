import 'package:flutter/material.dart';

class RiskFactorScreen extends StatelessWidget {
  const RiskFactorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title:const Text(
            'Risk factors'
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                            image: AssetImage('assets/images/risk factors.png')
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
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1- Smoking :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Your risk of lung cancer increases with the number of cigarettes you smoke each day and the number of years you have smoked.Quitting at any age can significantly lower your risk of developing lung cancer.'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2- Exposure to secondhand smoke :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                              'Even if you don\'t smoke, your risk of lung cancer increases if you\'re exposed to secondhand smoke.'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3 -Previous radiation therapy :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'If you\'ve undergone radiation therapy to the chest for another type of cancer, you may have an increased risk of developing lung cancer.'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4- Family history of lung cancer :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'People with a parent, sibling or child with lung cancer have an increased risk of the disease.'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5- Air Pollution :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'The World Health Organization named air pollution a cause of lung cancer in 2013. Lots of junk in the air we breathe -- exhaust, chemicals, dust -- factor in as well.But bad air as a whole, especially outside the U.S., is a major problem because of the sheer number of people who have to breathe it.'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '6- Radon gas exposure :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'This colorless, odorless gas forms as soil and rocks break down. As that happens, it seeps into buildings.It’s also radioactive and the second-leading cause of lung cancer (behind smoking) in the U.S. Radon is responsible for as many as 21,000 lung cancer deaths a year'
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
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '7- Asbestos exposures:',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Today this mineral is officially classified as a cause of cancer. It’s been banned for new uses since 1989,but for centuries folks weren’t aware of the dangers it posed. It was widely used to insulate and fireproof buildings.If you’re in the construction business, especially if you work on older buildings, you could be at risk.'
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
