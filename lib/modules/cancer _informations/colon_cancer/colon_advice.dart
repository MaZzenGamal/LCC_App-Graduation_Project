import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColonAdviceScreen extends StatelessWidget {
  const ColonAdviceScreen({Key? key}) : super(key: key);

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
                            image: AssetImage('assets/images/colonadvicephoto.jpg')
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
                            'Get daily physical activity :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- Regular exercise can help you manage your weight and reduce your risk of colon cancer, It’s hard to beat regular activity. It lowers the risk of many serious diseases, including colon cancer, and provides a good mental boost. Any amount of physical activity is better than none, but it’s good to try for around 30 minutes or more of moderate activity each day. Choose things you enjoy, like brisk walking, cycling, dancing or gardening.'
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
                            'Limit alcohol – Zero is best :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- While moderate drinking may be heart-healthy in older adults, drinking even low amounts of alcohol can raise the risk of colon cancer and breast cancer. And with the other risks of alcohol, not drinking is the overall healthiest choice.'
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
                            'Limit Red Meat, Especially Processed Meat :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- Eating too much red meat – like steak, hamburger and pork – increases the risk of colon cancer. And processed meats – like bacon, sausage and bologna – raise risk even more. Try to eat no more than three servings each week. Less is even better.'
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
                            'Get Enough Calcium and Vitamin D :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- There is good evidence that getting enough calcium and vitamin D can help protect against colon cancer. Try for 1000 to 1200 mg per day of calcium and about 1000 IU per day of vitamin D. Good sources of calcium include low-fat dairy, fortified plant-based milks, nuts, beans and greens. Good sources of vitamin D include eggs, fatty fish (like tuna) and fortified dairy products. A standard multivitamin can help fill gaps but should not take the place of real food or a healthy diet.'
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
                        '...Eat lots of vegetables, fruits, and whole grains. Diets that include lots of vegetables, fruits, and whole grains have been linked with a decreased risk of colon or rectal cancer. Also, eat less red meat (beef, pork, or lamb) and processed meats (hot dogs and some luncheon meats), which have been linked with an increased risk of colorectal cancer.'
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
                        '...Take control of your weight. Being overweight or obese increases your risk of getting and dying from colon or rectal cancer. Eating healthier and increasing your physical activity can help you control your weight.'
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
                      child: Text(
                        '...Don’t smoke. People who have been smoking for a long time are more likely than people who don\'t smoke to develop and die from colon or rectal cancer. '
                      )

                      )
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
