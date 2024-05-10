import 'dart:developer';

import 'package:demo_sih7/Screens/Upload/DiagnoseAPI.dart';
import 'package:demo_sih7/Screens/Upload/widgets/SymptomsList.dart';
import 'package:demo_sih7/Screens/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  // final List<TextEditingController> symptomControllers = [];
  // final List<String> symptoms = []; // Store entered symptoms
  bool gotImage = false;
  var ImagePath = null;
  List<String> savedSymptoms = [];
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    gotImage = false;
    ImagePath = null;
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    // symptomControllers.add(TextEditingController()); // Initial field
  }

  void UpdateGotImageValue(var imgpth) {
    setState(() {
      gotImage = true;
      ImagePath = imgpth;
    });
  }

  void _handleSymptomsUpdated(List<String> updatedSymptoms) {
    setState(() {
      savedSymptoms = updatedSymptoms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SymptomsList(onSymptomsUpdated: _handleSymptomsUpdated),
              SizedBox(height: 10),
              // Container(
              //   height: 300,
              //   width: 300,
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
              //   child: FutureBuilder<void>(
              //     future: _initializeControllerFuture,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         // If the Future is complete, display the preview.
              //         return CameraPreview(_controller);
              //       } else {
              //         // Otherwise, display a loading indicator with text.
              //         return const Center(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min, // Keeps the column as small as possible
              //             children: [
              //               CircularProgressIndicator(),
              //               SizedBox(height: 10), // Adds a bit of space
              //               Text("Loading camera"),
              //             ],
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),

              Container(
                height: 200,
                margin: const EdgeInsets.only(left: 15),
                padding: EdgeInsets.all(6),
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if ((snapshot.connectionState == ConnectionState.done) && (gotImage)) {
                      // If the Future is complete, display the preview.
                      return Container(
                        // width: 170,
                        // height: 170,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(width: 160, height: 140, child: Image.file(File(ImagePath))),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Image Captured !",
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      );
                    } else {
                      // Otherwise, display a loading indicator.
                      return Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Column(
                          children: [
                            Container(
                                width: 170, height: 130, child: Image.asset("assets/noImg.png")),
                            const Text(
                              "No Image Added !",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Take the Picture in a try / catch block. If anything goes wrong,
                        // catch the error.
                        print("Got Image = " + gotImage.toString());
                        try {
                          // // Ensure that the camera is initialized.
                          // await _initializeControllerFuture;
                          // // Attempt to take a picture and get the file `image`
                          // // where it was saved.
                          // final image = await _controller.takePicture();
                          // if (!mounted) return;

                          final ImagePicker _picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await _picker.pickImage(source: ImageSource.camera);

                          if (image != null) {
                            UpdateGotImageValue(image.path);
                          }
                          print("Got Image in trying = " + gotImage.toString());
                          // If the picture was taken, display it on a new screen.
                        } catch (e) {
                          // If an error occurs, log the error to the console.
                          log(e.toString());
                        }
                        print("Got Image after try = " + gotImage.toString());
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Take Picture'),
                    ),
                    SizedBox(width: 20),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     // Browse picture from local device and attach it
                    //   },
                    //   icon: Icon(Icons.photo_library),
                    //   label: Text('Browse Picture'),
                    // ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          // Use the selected image (e.g., display it, upload it, etc.)
                          // Example: Display the selected image
                          UpdateGotImageValue(image.path);
                          log("ImagePath $ImagePath");
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return Image.file(File(image.path));
                          //   },
                          // );
                        }
                      },
                      icon: Icon(Icons.photo_library),
                      label: Text('Browse Picture'),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gotImage ? Themes.greenClr : Themes.darkHeaderClr,
                        fixedSize: const Size(220, 50),
                        elevation: gotImage ? 5.0 : 0.0,
                      ),
                      onPressed: () async {
                        // Browse picture from local device and attach it
                        if (!gotImage) {
                        } else {
                          await sendImagePostRequest(ImagePath);
                        }
                      },
                      icon: gotImage
                          ? const Icon(
                              Icons.check_rounded,
                              size: 30,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.upload,
                              size: 30,
                              color: Colors.white,
                            ),
                      label: gotImage
                          ? const Text(
                              'Get Diagnosis',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            )
                          : const Text(
                              'Upload Image',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
