import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrueFalseQuestionDetail extends StatelessWidget {
  final String title;
  final String description;
  final double marks;
  final double negativeMarks;
  final bool correctAnswer;

  const TrueFalseQuestionDetail({
    super.key,
    required this.title,
    required this.description,
    required this.marks,
    required this.negativeMarks,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        title: Text(
          "Question Details",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(child: _buildQuestionCard(),)
                ],),
                const SizedBox(height: 20),
                _buildOptionsCard(),
                const SizedBox(height: 20),
                _buildMarksInfo(),
                const SizedBox(height: 20),
                _buildActionButtons(),
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
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsCard() {
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
              "Options:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[700],
              ),
            ),
            const SizedBox(height: 12),
            _buildOptionTile(true),
            const SizedBox(height: 8),
            _buildOptionTile(false),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(bool isTrue) {
    return ListTile(
      tileColor: correctAnswer == isTrue ? Colors.green[100] : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(
        isTrue ? Icons.check_circle : Icons.cancel,
        color: correctAnswer == isTrue ? Colors.green : Colors.red,
      ),
      title: Text(
        isTrue ? 'True' : 'False',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: correctAnswer == isTrue ? Colors.green[700] : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMarksInfo() {
    return Card(
      elevation: 4,
      color:Colors.blue.shade50,
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
            _buildMarkRow("Negative Marks:", negativeMarks),
            const SizedBox(height: 10),
            Text('Description :',style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
            Text(description,style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black))
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

  Widget _buildActionButtons() {
    return Column(

      children: [
        Row(
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
        ),

        const SizedBox(height: 50),
        ElevatedButton.icon(
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text('Add To Exam', style: GoogleFonts.poppins(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Add edit functionality
          },
        ),
      ],
    );
  }
}