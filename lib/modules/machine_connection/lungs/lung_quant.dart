import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'lung_classifier.dart';



class LungClassifierQuant extends LungClassifier {
  LungClassifierQuant({int numThreads: 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'lungs_model/lung_model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}