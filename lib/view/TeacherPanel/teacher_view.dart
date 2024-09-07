import 'package:app_genesis/view/Questions/TeacherAdds/true_false.dart';
import 'package:flutter/material.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({super.key});

  @override
  State<TeacherView> createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
            Tab(
              text: "Question Added",
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {});
        },
        children: const [
          StudentContent(title: 'Students Connected'),
          BatchContent(title: 'Batches'),
          ExamContent(title: 'Exams'),
          PageContent(title: 'Question Added'),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final String title;
  const PageContent({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton.icon(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TrueFalseScreen()));
        },
        label: const Text('Add a Questions'),
        icon: const Icon(Icons.question_answer_rounded),
      ),
    );
  }
}

class ExamContent extends StatelessWidget {
  final String title;
  const ExamContent({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton.icon(
        onPressed: () {},
        label: const Text('Create Exam'),
        icon: const Icon(Icons.compare),
      ),
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
      floatingActionButton: TextButton.icon(
        onPressed: () {},
        label: const Text('Create Batch'),
        icon: const Icon(Icons.batch_prediction_rounded),
      ),
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
      floatingActionButton: TextButton.icon(
        onPressed: () {},
        label: const Text('Connect Students'),
        icon: const Icon(Icons.connect_without_contact),
      ),
    );
  }
}
