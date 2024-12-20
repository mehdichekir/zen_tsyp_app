import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map> uploadToCloudinary(FilePickerResult? filePickerResult )async{
  if(filePickerResult == null || filePickerResult.files.isEmpty){
    print("No file selected");
    return {};
  } 
  

  File file =File(filePickerResult.files.single.path!);

  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/raw/upload");
  var request = http.MultipartRequest("POST", uri);

  var fileBytes = await file.readAsBytes();
    var multipartFile = http.MultipartFile.fromBytes('file',
    fileBytes,
    filename: file.path.split("/").last,
    );

  request.files.add(multipartFile);

  request.fields['upload_preset'] = "upload_images";
  request.fields['resource_type'] = "raw";

  var response = await request.send();

  var responseBody = await response.stream.bytesToString();

  print(responseBody);
    if (response.statusCode == 200){
      var jsonResponse=jsonDecode(responseBody);
      Map<String,String> requiredData={
        "public_id":jsonResponse["public_id"],
        "size":jsonResponse["bytes"].toString(),
        "ressources_type":jsonResponse["resource_type"],
        "url":jsonResponse["secure_url"],
        "created_at":jsonResponse["created_at"],
        "name":jsonResponse["display_name"],
      };
      print("Upload successful!");
      return requiredData;
    } else {
      print("Upload failed with status: ${response.statusCode}");
      return {};
    }

}








// Future<Map> uploadToCloudinary(FilePickerResult? filePickerResult )async{
//   if(filePickerResult == null || filePickerResult.files.isEmpty){
//     print("No file selected");
//     return {};
//   } 
  

//   File file =File(filePickerResult.files.single.path!);

//   String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

//   var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
//   var request = http.MultipartRequest("POST", uri);

//   var fileBytes = await file.readAsBytes();
//     var multipartFile = http.MultipartFile.fromBytes('file',
//     fileBytes,
//     filename: file.path.split("/").last,
//     );

//   request.files.add(multipartFile);

//   request.fields['upload_preset'] = "image-events";
//   request.fields['resource_type'] = "image";

//   var response = await request.send();

//   var responseBody = await response.stream.bytesToString();

//   print(responseBody);
//     if (response.statusCode == 200){
//       var jsonResponse=jsonDecode(responseBody);
//       Map<String,String> requiredData={
//         "public_id":jsonResponse["public_id"],
//         "secure_url":jsonResponse["secure_url"],
//         "size":jsonResponse["bytes"].toString(),
//         "ressources_type":jsonResponse["resource_type"],
//         "url":jsonResponse["secured_url"],
//         "created_at":jsonResponse["created_at"],
//         "name":jsonResponse["display_name"],
//       };
//       //await DbServiceEvents().saveUploadedImage(requiredData);
//       print("Upload successful!");
//       return requiredData;
//     } else {
//       print("Upload failed with status: ${response.statusCode}");
//       return {};
//     }

// }