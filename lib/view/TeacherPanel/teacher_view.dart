import 'dart:ui';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/models/Questions/answer_fetch_model.dart';
import 'package:app_genesis/models/Questions/question_fetch_model.dart';
import 'package:app_genesis/models/test_fetch.dart';
import 'package:app_genesis/utils/fonts.dart';
import 'package:app_genesis/view/CreateExam/add_test.dart';
import 'package:app_genesis/view/CreateExam/exam_detail.dart';
import 'package:app_genesis/view/Questions/TeacherAdds/true_false.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_fill_in_the_blanks.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_match_the_following.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_mcq.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_multi_correct.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_true_false.dart';
import 'package:flutter/material.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({super.key});

  @override
  State<TeacherView> createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;
  late Future<List<QuestionFetchModel>> futureQuestions;
  late Future<List<TestModel>> futureTests;
  final api = ApiController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fetchData();
  }

  void _fetchData() {
    futureTests = api.fetchTest();
    futureQuestions = api.fetchQuestions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {});
          },
          tabs: const [
            Tab(text: "Students Connected"),
            Tab(text: "Batches"),
            Tab(text: "Exams"),
            Tab(text: "Questions Added"),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {});
        },
        children: [
          const StudentContent(title: 'Students Connected'),
          const BatchContent(title: 'Batches'),
          ExamContent(title: 'Exams', futureTests: futureTests),
          PageContent(futureQuestions: futureQuestions),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final Future<List<QuestionFetchModel>> futureQuestions;
  const PageContent({super.key, required this.futureQuestions});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(context, 'Add a Question', const TrueFalseScreen()),
      body: _buildFutureBuilder<QuestionFetchModel>(futureQuestions, _buildQuestionCard),
    );
  }
  Widget _buildFloatingActionButton(BuildContext context, String label, Widget destination) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
      },
      label: Text(label),
      icon: const Icon(Icons.question_answer_rounded),
    );
  }
  Widget _buildFutureBuilder<T>(Future<List<T>> future, Widget Function(T,BuildContext) itemBuilder) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.cyan));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => itemBuilder(snapshot.data![index],context),
          );
        } else {
          return const Center(child: Text('No items found.'));
        }
      },
    );
  }

  Widget _buildQuestionCard(QuestionFetchModel question,BuildContext context) {
    return _buildCard(
      type: question.questionType,
      title: question.questionText,
      question: question,
      context: context,
      details: [
        _buildInfoRow(Icons.category, 'Type', question.questionType),
        _buildInfoRow(Icons.description, 'Description', question.description),
        _buildInfoRow(Icons.star, 'Marks', question.marks.toString()),
        _buildInfoRow(Icons.public, 'Public', question.isPublic ? 'Yes' : 'No'),
      ],
    );
  }

  Widget _buildCard({required String title, required List<Widget> details,required BuildContext context,required String type,required QuestionFetchModel question}) {
    return InkWell(
      onTap: () {
        switch (question.questionType) {
          case 'FIBL':
            Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPageFillInTheBlanks(questionText:question.questionText,description: question.description,mark: question.marks,negativeMark: -1, correctAnswers: [(question.answer as FillUpsAnswerModel).answer])));
            break;
          case 'MCQ':
            Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCorrectQuestions(questionText: question.questionText, description: question.description, marks: question.marks, negativeMark:-1, choices:(question.answer as SingleChoiceAnswerModel).choices, correctAnswer: (question.answer as SingleChoiceAnswerModel).correctAnswer,)));
            break;
          case 'MTF':
            Navigator.push(context, MaterialPageRoute(builder: (context) =>MatchTheFollowingQuestion(questionText: question.questionText,pairs: (question.answer as MatchAnswerModel).pairs, description: question.description, mark: question.marks, negativeMark: -1) ));
            break;
          case 'MAMCQ':
            Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionDetailScreen(questionText: question.questionText,description: question.description,marks: question.marks,negativeMark: -1,choices: (question.answer as MultipleChoiceAnswerModel).choices,correctAnswers: (question.answer as MultipleChoiceAnswerModel).correctAnswers,)));
            break;
          case 'TF':
            Navigator.push(context, MaterialPageRoute(builder: (context) =>TrueFalseQuestionDetail(title: question.questionText, description:question.description , marks: question.marks, negativeMarks: -1, correctAnswer:(question.answer as TFAnswerModel).correctAnswer)));
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown question type')));
        }
      },
      child: Card(
        color: Colors.grey.shade100,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                        Expanded(child: Text(title, style: AppTextStyles.body(color: Colors.black))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: details),
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
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.cyan),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
      ],
    );
  }
}
class ExamContent extends StatelessWidget {
  final String title;
  final Future<List<TestModel>> futureTests;
  const ExamContent({super.key, required this.title, required this.futureTests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(context, 'Create Exam', const ExamDetailsScreen()),
      body: _buildFutureBuilder<TestModel>(futureTests,_buildTestCard),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, String label, Widget destination) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      label: Text(label),
      icon: const Icon(Icons.compare),
    );
  }

  Widget _buildFutureBuilder<T>(Future<List<T>> future, Widget Function(T,BuildContext) itemBuilder) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => itemBuilder(snapshot.data![index],context),
          );
        } else {
          return const Center(child: Text('No items found.'));
        }
      },
    );
  }

  Widget _buildTestCard(TestModel test,BuildContext context) {
    return _buildCard(
      title: test.title,
      context: context,
      test:test,
      details: [
        _buildInfoRow(Icons.category, 'Topic', test.topic),
        _buildInfoRow(Icons.timer, 'Duration', test.duration),
        _buildInfoRow(Icons.description, 'Description', test.description),
      ],
    );
  }

  Widget _buildCard({required String title, required List<Widget> details,required BuildContext context,required TestModel test}) {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>TestDetailPage(id: test.id)));
      },
      child: Card(
        color: Colors.grey.shade100,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                        Expanded(child: Text(title, style: AppTextStyles.body(color: Colors.black))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: details),
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
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.cyan),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
      ],
    );
  }
}

class BatchContent extends StatelessWidget {
  final String title;

  const BatchContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return TextButton.icon(
      onPressed: () {},
      label: const Text('Create Batch'),
      icon: const Icon(Icons.batch_prediction_rounded),
    );
  }
}

class StudentContent extends StatelessWidget {
  final String title;

  const StudentContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return TextButton.icon(
      onPressed: () {},
      label: const Text('Connect Students'),
      icon: const Icon(Icons.connect_without_contact),
    );
  }
}
