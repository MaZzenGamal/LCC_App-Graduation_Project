import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'lung_classifier.dart';



class LungClassifierFloat extends LungClassifier {
  LungClassifierFloat({int? numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'lungs_model/lung_model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}