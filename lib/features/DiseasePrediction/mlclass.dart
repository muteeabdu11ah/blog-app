// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui; // Usually needed for the Color class

// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
// import 'package:flutter/services.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img; 
// import 'package:image_picker/image_picker.dart';

// class MLModel {
//   FirebaseCustomModel? model;
//   Interpreter? interpreter; // Add interpreter
//   List<double> outputs = [];
  
// static const platform = MethodChannel('com.example.flutter_python_bridge');

//   static Future<Uint8List> preprocesssImage(String imagePath) async {
//     try {
//       final Uint8List result = await platform.invokeMethod('preprocessImage', {"imagePath": imagePath});
//       return result;
//     } on PlatformException catch (e) {
//       print("Failed to preprocess image: '${e.message}'.");
//       throw Exception();
//   }
// }


// Future<Uint8List?> pickImageMlModel() async {
//   try {
//     final xfile = await ImagePicker().pickImage(
//       imageQuality: 50,
//       source: ImageSource.gallery,
//     );
//     if (xfile != null) {
//       return await xfile.readAsBytes();
//     }
//     return null;
//   } catch (e) {
//     return null;
//   }
// }

//   initWithLocalModel() async {
//     try {
//   model = await FirebaseModelDownloader.instance.getModel(
//       'mrimodel', FirebaseModelDownloadType.localModelUpdateInBackground);
  
//   // Assuming 'mrimodel' is in .tflite format or convert if needed 
//   final modelPath = model!.file; // Get path to the downloaded model file
//   interpreter = Interpreter.fromFile(modelPath); 
// } on Exception catch (e) {
//     throw Exception(e.toString());
// }
//   }

//   // Function for image classification (adjust input/output as needed)
//   Future<List<String>> classifyImage(Uint8List imageData) async {
//     if (interpreter == null) {
//       throw Exception('Model not loaded. Please call initWithLocalModel() first.');
//     }

//     // Pre-process the image data


//     // Run inference 
//     interpreter?.run([[[]]], outputs);

//     // Post-process the results 
//     final classifiedLabels = postprocessResults(outputs); 

//     return classifiedLabels;
//   }

  


// Uint8List preprocessImage(String imagePath, {List<int> targetSize = const [128, 128]}) {
//   // Open the image file
//   final bytes = File(imagePath).readAsBytesSync();
//   img.Image? image = img.decodeImage(Uint8List.fromList(bytes));

//   // Resize the image
//   image = img.copyResize(image!, width: targetSize[0], height: targetSize[1]);

//   // Convert the image to a Uint8List
//   final resizedBytes = Uint8List.fromList(img.encodePng(image));

//   return resizedBytes;
// }

// // Inside your MLModel class ...

// List<String> postprocessResults(List<double> outputs) {
//   // Assuming your model outputs class probabilities in the order mentioned
//   const labels = ['Mild Demented', 'Non Demented', 'Very Mild Demented', 'Moderate Demented'];

//   // Find the index of the highest probability
//   int maxIndex = 0;
//   for (int i = 1; i < outputs.length; i++) {
//     if (outputs[i] > outputs[maxIndex]) {
//       maxIndex = i;
//     }
//   }

//   // Return the label with the highest probability
//   return [labels[maxIndex]]; 
// }


// }

