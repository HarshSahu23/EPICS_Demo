import 'package:flutter/material.dart';

class SymptomsList extends StatefulWidget {
  final Function(List<String>) onSymptomsUpdated;
  const SymptomsList({super.key, required this.onSymptomsUpdated});

  @override
  State<SymptomsList> createState() => _SymptomsListState();
}

class _SymptomsListState extends State<SymptomsList> {
  final List<TextEditingController> symptomControllers = [];
  final List<String> symptoms = []; // Store entered symptoms

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    symptomControllers.add(TextEditingController()); // Initial field
  }

  @override
  void dispose() {
    // Important: Dispose controllers to avoid memory leaks
    for (final controller in symptomControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void saveSymptoms() {
    for (final controller in symptomControllers) {
      symptoms.add(controller.text);
    }

    widget.onSymptomsUpdated(symptoms);
  }

  List<String> getSymptoms() {
    return symptoms;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Symptoms',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          // Use Column to stack the input fields
          children: [
            ...symptomControllers
                .map((controller) => TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter symptom',
                      ),
                    ))
                .toList(),
            Row(
              children: [
                Expanded(child: Container()), // Push add button to the right
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      symptomControllers.add(TextEditingController());
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
