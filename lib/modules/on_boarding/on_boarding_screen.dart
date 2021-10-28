import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/layouts/app_layout.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModel> boarding=
  [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'
    ),
  ];
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value!)
      {
        navigateAndFinish(context, const AppLayout());
      }
    });

  }
  bool isLast = false;
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
                    image: AssetImage('assets/images/softBack.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(onPressed: submit, child:const Text(
                    'SKIP',
                    style: TextStyle(
                        fontSize: 25.0
                    ),
                  )),
                  Expanded(
                      child:PageView.builder(itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                        controller: boardController,
                        itemCount: boarding.length,
                        onPageChanged: (int index){
                          if(index == boarding.length-1)
                          {
                            setState(() {
                              isLast = true;
                            });
                          }else
                          {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                        physics:const BouncingScrollPhysics(),
                      )
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(controller: boardController,
                        effect:const SwapEffect(
                          radius: 10,
                          activeDotColor: Colors.tealAccent,
                          dotColor: Colors.blue,
                        ),
                        count: boarding.length,
                      ),
                      const Spacer(),
                      FloatingActionButton(onPressed: ()
                      {
                        boardController.nextPage(
                            duration:const Duration(milliseconds: 750),
                            curve: Curves.easeInQuint);
                        if(isLast == true)
                          {
                            submit();
                          }
                      },
                        child:const Icon(
                          EvaIcons.arrowRight,
                          color: Colors.tealAccent,
                        ),)
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );

  }
}

Widget buildBoardingItem(BoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:  [
    Expanded(
      child: Center(
        child: Image(
          image: AssetImage(model.image),
          height: 350.0,
          width: double.infinity,
        ),
      ),
    ),
    Text(
      model.title,
      style: const TextStyle(
          fontWeight:FontWeight.bold,
          fontSize: 30.0
      ),
    ),
   const SizedBox(
      height: 20.0,
    ),
    Text(
      model.body,
      style:const TextStyle(
          fontSize: 20.0
      ),
    ),
  ],
);



