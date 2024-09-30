import 'dart:ui';
import 'package:app_genesis/models/answer_model.dart';
import 'package:app_genesis/utils/options_picker.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_fill_in_the_blanks.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_match_the_following.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_mcq.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_multi_correct.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_true_false.dart';
import 'package:flutter/material.dart';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/models/specific_test.dart';
import 'package:app_genesis/models/question_fetch.dart';

class TestDetailPage extends StatefulWidget {
  final int id;
  const TestDetailPage({super.key, required this.id});
  @override
  State<TestDetailPage> createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {
  late Future<TestData?> futureSpecificTest;
  final optionsPicker = OptionPicker();
  final api = ApiController();

  @override
  void initState() {
    super.initState();
    futureSpecificTest = api.fetchSpecificTest(widget.id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          optionsPicker.showQuestionPicker(context,widget.id);
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Questions', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      appBar: AppBar(
        title: const Text('Test Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<TestData?>(
        future: futureSpecificTest,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.cyan));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (snapshot.hasData && snapshot.data != null) {
            TestData testData = snapshot.data!;
            return _buildTestDetails(testData);
          } else {
            return const Center(child: Text('No data available', style: TextStyle(color: Colors.grey)));
          }
        },
      ),
    );
  }

  Widget _buildTestDetails(TestData testData) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard("Test Information", [
              _buildDetailRow(Icons.subject, "Topic", testData.topic),
              _buildDetailRow(Icons.description, "Description", testData.description),
              _buildDetailRow(Icons.timer, "Duration", '${testData.duration} minutes'),
            ]),
            const SizedBox(height: 16.0),
            _buildSectionHeading("Questions"),
            ...testData.questions.map((question) => _buildQuestionCard(question, context)),
            const SizedBox(height: 16.0),
            Center(child: _buildHelpText())
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.cyan, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                Text(value, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(QuestionFetch question, BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: InkWell(
              onTap: () {
                switch (question.questionType) {
                  case 'FIBL':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPageFillInTheBlanks(questionText:question.questionText,description: question.description,mark: question.marks,negativeMark: -1, correctAnswers: [(question.answer as FillInTheBlankAnswer).answer])));
                    break;
                  case 'MCQ':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCorrectQuestions(questionText: question.questionText, description: question.description, marks: question.marks, negativeMark:-1, choices:(question.answer as SingleChoiceAnswer).choices, correctAnswer: (question.answer as SingleChoiceAnswer).correctAnswer,)));
                    break;
                  case 'MTF':
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>MatchTheFollowingQuestion(questionText: question.questionText,pairs: (question.answer as MatchTheFollowingAnswer).pairs, description: question.description, mark: question.marks, negativeMark: -1) ));
                    break;
                  case 'MAMCQ':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailScreen(questionText: question.questionText,description: question.description,marks: question.marks,negativeMark: -1,choices: (question.answer as MultipleChoiceAnswer).choices,correctAnswers: (question.answer as MultipleChoiceAnswer).correctAnswers,)));
                    break;
                  case 'TF':
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>TrueFalseQuestionDetail(title: question.questionText, description:question.description , marks: question.marks, negativeMarks: -1, correctAnswer:(question.answer as TrueFalseAnswer).correctAnswer)));
                    break;
                  default:
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown question type')));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.question_answer, color: Colors.black),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.questionText,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.category, 'Type', question.questionType),
                        _buildInfoRow(Icons.description, 'Description', question.description),
                        _buildInfoRow(Icons.star, 'Marks', question.marks.toString()),
                        _buildInfoRow(Icons.public, 'Public', question.isPublic ? 'Yes' : 'No'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.cyan),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildHelpText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Tap on a question to view or edit its details.',
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }
}