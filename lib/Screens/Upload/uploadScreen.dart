import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<TextEditingController> symptomControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(8),
              child: Text(
                'No pictures attached',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.camera),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in symptomControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
