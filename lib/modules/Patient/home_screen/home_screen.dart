import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/Patient/settings_screen/settings_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/advice_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/cancer_info_screen.dart';
import 'package:graduation_project/modules/cancer%20_informations/motivation_screen.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> home = [
      'assets/images/slider4.jpg',
      'assets/images/slider5.jpg',
      'assets/images/slider6.jpg',
    ];
    List<Choice> choices =  <Choice>[
      Choice(title: 'Syndromes', image:'assets/images/grid/syndromes.png',color: HexColor('c6cefb'),function:(){navigateTo(context, SyndromesScreen());}),
      Choice(title: 'X-Ray', image:'assets/images/grid/x-Ray.png',color: HexColor('ff92a4'),function:(){navigateTo(context,const MotivationScreen());}),
      Choice(title: 'Advice', image:'assets/images/grid/advice.png',color: HexColor('ffe9ce'),function:(){navigateTo(context,const AdviceScreen());}),
      Choice(title: 'General Informations', image:'assets/images/grid/inf.png',color: HexColor('ffdd83'),function:(){navigateTo(context,const CancerInfoScreen());}),
    ];
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // CAROUSAL SLIDER //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color:HexColor('4E51BF'),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor('4E51BF').withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset:const Offset(0, 10), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CarouselSlider(
                      items: home.map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(e,
                        fit: BoxFit.cover,
                        ),
                      )).toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 200.0,
                        autoPlay: true,
                        autoPlayAnimationDuration:const Duration(seconds: 1),
                        autoPlayInterval:const Duration(seconds: 6),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 50.0,
                        //enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        scrollDirection: Axis.horizontal,
                        // viewportFraction: 1.0,
                        reverse: false,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GridView.count(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 2.0,
              children: List.generate(choices.length, (index){
                return Center(
                  child: SelectCard(choice:choices[index],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
class Choice {
  const Choice({
    required this.title,
    required this.image,
    required this.color,
    required this.function,
  });
  final String title;
  final String image;
  final HexColor color;
  final Function()? function;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, this.choice}) : super(key: key);
  final Choice? choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
      color: Colors.black54,
      shadows:const [
        Shadow(
          color: Colors.white,
          blurRadius: 3,
          offset:  Offset(0, 1),
        )
      ]
    );
    return InkWell(
      onTap: choice!.function,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
          height: 160.0,
          width: 160.0,
          decoration: BoxDecoration(
            color: choice!.color,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: choice!.color.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 13,
                offset:const Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:Image.asset(
                          choice!.image,
                        fit: BoxFit.cover,
                        ),
                      ),
                  Text(choice!.title,
                    style: textStyle,
                    textAlign: TextAlign.center,),
                ]
          ),
            ),
          )
      ),
    );
  }
}  



