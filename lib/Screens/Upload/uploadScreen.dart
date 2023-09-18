import 'package:demo_sih7/Screens/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<TextEditingController> symptomControllers = [TextEditingController()];
  bool gotImage = false;
  var ImagePath = null;
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
  }

  void UpdateGotImageValue(var imgpth) {
    setState(() {
      gotImage = true;
      ImagePath = imgpth;
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
              Text(
                'Symptoms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: symptomControllers.map((controller) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Enter symptom',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            symptomControllers.add(TextEditingController());
                          });
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              // SizedBox(height: 20),
              Container(
                height: 300,
                width: 300,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3)),
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the preview.
                      return CameraPreview(_controller);
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Take the Picture in a try / catch block. If anything goes wrong,
                      // catch the error.
                      print("Got Image = " + gotImage.toString());
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;

                        // Attempt to take a picture and get the file `image`
                        // where it was saved.
                        final image = await _controller.takePicture();

                        if (!mounted) return;

                        UpdateGotImageValue(image.path);
                        print("Got Image in trying = " + gotImage.toString());
                        // If the picture was taken, display it on a new screen.
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                      print("Got Image after try = " + gotImage.toString());
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Take Picture'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Browse picture from local device and attach it
                    },
                    icon: Icon(Icons.photo_library),
                    label: Text('Browse Picture'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if ((snapshot.connectionState == ConnectionState.done) &&
                        (gotImage)) {
                      // If the Future is complete, display the preview.
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                                width: 90,
                                height: 90,
                                child: Image.file(File(ImagePath))),
                            const Text(
                              "Image Captured !",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      );
                    } else {
                      // Otherwise, display a loading indicator.
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                                width: 90,
                                height: 90,
                                child: Image.asset("assets/noImg.png")),
                            const Text(
                              "No Image Added !",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Themes.pinkClr,
                          fixedSize: Size(200, 50)),
                      onPressed: () {
                        // Browse picture from local device and attach it
                      },
                      icon: const Icon(
                        Icons.upload,
                        size: 30,
                      ),
                      label: const Text(
                        'Upload Image',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in symptomControllers) {
      controller.dispose();
    }
    _controller.dispose();
    super.dispose();
  }
}
