import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'colon_classifier.dart';

class ColonClassifierFloat extends ColonClassifier {
  ColonClassifierFloat({int? numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'colon_model/model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}