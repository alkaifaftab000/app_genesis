import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionDetailScreen extends StatelessWidget {
  final String questionText;
  final String description;
  final double marks;
  final double negativeMark;
  final Map<String, String> choices; // Change from List<String> to Map<String, String>
  final List<String> correctAnswers; // Change to List<String> for correct answers

  const QuestionDetailScreen({
    super.key,
    required this.questionText,
    required this.description,
    required this.marks,
    required this.negativeMark,
    required this.choices,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Expanded(child: _buildCard('Question:', questionText))]),
              _buildOptions(),
              Row(children: [Expanded(child: _buildCard('Description:', description))]),
              _buildMarksInfo(),
              const SizedBox(height: 20),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(content, style: GoogleFonts.poppins(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: choices.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: correctAnswers.contains(entry.key) ? Colors.green.shade100 : Colors.blue.shade100,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: correctAnswers.contains(entry.key) ? Colors.green : Colors.blue,
                child: Text(
                  entry.key, // Use the key (A, B, C, etc.)
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              title: Text(
                entry.value, // Use the value (choice text)
                style: GoogleFonts.poppins(
                  color: correctAnswers.contains(entry.key) ? Colors.green.shade700 : Colors.blue.shade700,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMarksInfo() {
    return Card(
      elevation: 4,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Information:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[700],
              ),
            ),
            const SizedBox(height: 8),
            _buildMarkRow("Marks:", marks),
            _buildMarkRow("Negative Marks:", negativeMark),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value.toStringAsFixed(2),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: label.contains("Negative") ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.edit, color: Colors.white),
          label: Text('Edit', style: GoogleFonts.poppins(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Add edit functionality
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.delete, color: Colors.white),
          label: Text('Delete', style: GoogleFonts.poppins(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Add delete functionality
          },
        ),
      ],
    );
  }
}
