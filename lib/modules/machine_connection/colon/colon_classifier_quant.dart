import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'colon_classifier.dart';


class ColonClassifierQuant extends ColonClassifier {
  ColonClassifierQuant({int numThreads: 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'colon_model/model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}