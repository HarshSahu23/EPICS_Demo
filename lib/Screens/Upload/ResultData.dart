import 'package:flutter/material.dart';
import '../theme.dart'; // Import the file with your Themes class

class DiagnosisResultsUI extends StatelessWidget {
  final Map<String, dynamic> diagnosisData;

  DiagnosisResultsUI({required this.diagnosisData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skin Diagnosis Results"),
        backgroundColor: Themes.bluishClr,
      ),
      body: Container(
        decoration: BoxDecoration(
          // Subtle background gradient
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Themes.white, Themes.bluishClr.withOpacity(0.3)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // Allow scrolling if content exceeds space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultItem(
                    "Image Quality Score", diagnosisData['data']['image_quality'].toString()),
                _buildResultItem("Body Part", diagnosisData['data']['body_part']),
                const SizedBox(height: 20),
                Text("Diagnosis Results",
                    style: TextStyle(
                      color: Themes.darkGreyClr,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(height: 10),
                ...diagnosisData['data']['results_english']
                    .entries
                    .map((entry) => _buildResultItem(
                        entry.key, "${(entry.value * 100).toStringAsFixed(1)}%",
                        color: Themes.greenClr))
                    .toList(),
                const SizedBox(height: 20),
                _buildDisclaimer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, String value, {Color color = Themes.bluishClr}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Text(
      "Disclaimer: This information is not intended as a substitute for professional medical advice.",
      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
    );
  }
}
