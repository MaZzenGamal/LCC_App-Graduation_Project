import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancerTypesScreen extends StatelessWidget {
  const CancerTypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Lung cancer types'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 190.0,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    shape: BoxShape.rectangle,
                    image:const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/types-lung-cancer.png')
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
                      '1- Small cell lung cancer :',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Small cell lung cancer occurs almost exclusively in heavy smokers and is less common than non-small cell lung cancer.'
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
                        '2- Non-small cell lung cancer :',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Non-small cell lung cancer is an umbrella term for several types of lung cancers.'
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
              child:const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:Text(
                    '...Non-small cell lung cancers include squamous cell carcinoma, adenocarcinoma and large cell carcinoma.'
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
