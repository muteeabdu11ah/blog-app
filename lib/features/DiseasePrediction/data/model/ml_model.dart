import 'dart:ffi';

import 'package:fyp/features/DiseasePrediction/domain/entity/ml.dart';

class MlModel extends ML {
  MlModel({ required super.diseaseName, required super.confidence });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'predicted_class': diseaseName,
      'accuracy': confidence,
    };
  }

  MlModel copyWith({
    String? diseaseName,
    double? confidence,

  }) {
    return MlModel(
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,

    );
  }

  factory MlModel.fromJson(Map<String, dynamic> map) {
    return MlModel(
      diseaseName: map['predicted_class'] as String,
      confidence: map['accuracy'] as double,
    );
  }
}
