import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:path/path.dart';

Future<void> sendImagePostRequest(String imgPath) async {
  // Replace with your actual API Keys and Host
  const apiKey = 'a0764596camshec07b5605991ec0p1f0136jsn954e8fa8385c';
  const apiHost = 'detect-skin-disease.p.rapidapi.com';
  const apiEndpoint = 'http://10.0.2.2:3000/upload'; // Adjust for your API

  // Step 1: Pick an Image
  // final ImagePicker picker = ImagePicker();
  // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  // if (image == null) return; // Image selection was cancelled

  // Step 2: Prepare image bytes
  File imageFile = File(imgPath);
  List<int> imageBytes = await imageFile.readAsBytes();

  // Step 3: Prepare the Multipart Request
  var request = http.MultipartRequest('POST', Uri.parse(apiEndpoint));
  request.headers['x-rapidapi-key'] = apiKey;
  request.headers['x-rapidapi-host'] = apiHost;

  // Add the image file as multipart/form-data
  request.files.add(
    http.MultipartFile.fromBytes(
      'image', // Field name - adjust as per your API
      imageBytes,
      filename: basename(imageFile.path),
    ),
  );

  // Step 4: Send the request
  try {
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    // Step 5: Process the response
    print("Status code: ${response.statusCode}");
    print("Response body: $responseBody");
  } catch (error) {
    print("Error: $error");
  }
}
