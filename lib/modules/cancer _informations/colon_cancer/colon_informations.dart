import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColonInfoScreen extends StatelessWidget {
  const ColonInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title:const Text(
            'Colon cancer Info...'
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
                            image: AssetImage('assets/images/colonInfo pic.jpg')
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
                  child:const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text(
                        '- Colon cancer typically affects older adults, though it can happen at any age. It usually begins as small, noncancerous (benign) clumps of cells called polyps that form on the inside of the colon. Over time some of these polyps can become colon cancers.'
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
                            'Doctors arn\'t certain what causes most colon cancers :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- In general, colon cancer begins when healthy cells in the colon develop changes (mutations) in their DNA. A cell\'s DNA contains a set of instructions that tell a cell what to do. Healthy cells grow and divide in an orderly way to keep your body functioning normally. But when a cell\'s DNA is damaged and becomes cancerous, cells continue to divide — even when new cells arn\'t needed. As the cells accumulate, they form a tumor. With time, the cancer cells can grow to invade and destroy normal tissue nearby. And cancerous cells can travel to other parts of the body to form deposits there (metastasis).'
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
                            'Factors that may increase your risk of colon cancer include :',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '- Older age. Colon cancer can be diagnosed at any age, but a majority of people with colon cancer are older than 50. The rates of colon cancer in people younger than 50 have been increasing, but doctors arn\'t sure why.'
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
                        '...African-American race. African-Americans have a greater risk of colon cancer than do people of other races.'
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
                        '...A personal history of colorectal cancer or polyps. If you\'ve already had colon cancer or noncancerous colon polyps, you have a greater risk of colon cancer in the future.'
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
