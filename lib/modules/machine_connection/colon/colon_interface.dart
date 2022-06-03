import 'dart:io';
import 'package:graduation_project/modules/machine_connection/colon/colon_classifier_quant.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import '../../../shared/components/components.dart';
import '../Uninfected.dart';
import '../infected.dart';
import 'colon_classifier.dart';


class ColonInterface extends StatefulWidget {
  const ColonInterface({Key? key}) : super(key: key);

  @override
  _ColonInterfaceState createState() => _ColonInterfaceState();
}

class _ColonInterfaceState extends State<ColonInterface> {
  late ColonClassifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  @override
  void initState() {
    super.initState();
    _classifier = ColonClassifierQuant();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Container(
              width: 250,
              height: 250,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
              ),
              child: const Center(child: Text('No image selected.')),
            )
                : Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: _imageWidget,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
         /* Text(
            category != null ? category!.label : '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category != null
                ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
                : '',
            style: TextStyle(fontSize: 16),
          ),*/
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              if( category != null){
                if(category!.label=='normal'){
                  navigateTo(context,const UnifectedScreen());
                }
                else
                {
                  navigateTo(context, InfectedScreen(type: 'lung cancer', degree: category!.score, label: category!.label));

                }
              }

            },
            child: const Text('Show Result'),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('ff92a4'),
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
