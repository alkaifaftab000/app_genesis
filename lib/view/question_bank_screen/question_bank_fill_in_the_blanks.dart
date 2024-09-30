import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPageFillInTheBlanks extends StatelessWidget {
  final String questionText;
  final String description;
  final double mark;
  final double negativeMark;
  final List<String> correctAnswers; // Options to display

  const QuizPageFillInTheBlanks({
    super.key,
    required this.questionText,
    required this.correctAnswers,
    required this.description,
    required this.mark,
    required this.negativeMark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        title: Text(
          "Fill in the Blanks Quiz",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQuestionCard(),
                const SizedBox(height: 20),
                _buildAnswerFields(), // Displaying options
                const SizedBox(height: 20),
                _buildMarksInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.cyan.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              questionText,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerFields() {
    return Column(
      children: List.generate(
        correctAnswers.length,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              correctAnswers[index],
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
            ),
            leading: const Icon(
              Icons.check_circle, // Indicating it's an option
              color: Colors.green,
            ),
          ),
        ),
      ),
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
            _buildMarkRow("Marks:", mark),
            _buildMarkRow("Negative Marks:", negativeMark),
            const SizedBox(height: 10),
            Text(
              'Description:',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Text(
              description,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
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
}
