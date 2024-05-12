import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:fyp/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../model/ml_model.dart';

abstract interface class MlRemoteDataSource {
  Future<MlModel> mlModelPredict(File imageFile);
}

class MlRemoteDataSourceImpl implements MlRemoteDataSource{
  @override
  Future<MlModel> mlModelPredict(File imageFile) async {
    try {
    var apiUrl = Uri.parse('https://deploy1-cos6esdchq-uc.a.run.app/data');
    
    // Create a multipart request
    var request = http.MultipartRequest('POST', apiUrl);
    
    // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    
    // Send the request
    var response = await request.send();
    print(response);
    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response body
      var responseBody = await response.stream.bytesToString();
      
      
var responseMap = jsonDecode(responseBody);
      
      // Extract predicted class and accuracy from the map
      var predictedClass = responseMap['predicted_class'] as String;
      var accuracy = responseMap['accuracy'] as double; // Assuming accuracy is a double
      
      // Create and return an MlModel instance
      return MlModel(diseaseName: predictedClass, confidence: accuracy);
        } 
    else {
      print('failed');
      // If the request failed, throw a ServerException with the error message
      throw ServerException('Failed to get predictions. Status code: ${response.statusCode}');
    }
    } on ServerException catch(e){
      throw(e.message);
    }
  }

}