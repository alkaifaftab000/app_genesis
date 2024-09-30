import 'dart:ui';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/models/Filtered_Questions/filtered_answer.dart';
import 'package:app_genesis/models/Filtered_Questions/flitered_question.dart';
import 'package:app_genesis/view/CreateExam/exam_detail.dart';
import 'package:flutter/material.dart';
import 'package:app_genesis/utils/fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app_genesis/view/question_bank_screen/question_bank_match_the_following.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_mcq.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_multi_correct.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_true_false.dart';
import 'package:app_genesis/view/question_bank_screen/question_bank_fill_in_the_blanks.dart';

class FromQuestionBank extends StatefulWidget {
  final int id;
  const FromQuestionBank({super.key,required this.id});
  @override
  FromQuestionBankState createState() => FromQuestionBankState();
}
class FromQuestionBankState extends State<FromQuestionBank> {
  final List<int> addMoreQuestion=[];
  String? questionType;
  List<FilteredQuestionModel>? filteredQuestions;

  final List<String> questionTypes = [
    'MCQ',
    'True/False',
    'Fill in the Blanks',
    'Multi Correct MCQ',
    'Match The Following'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(onPressed: ()async{
        if(addMoreQuestion.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("You have'nt selected any question please select first"))
          );
        }else{
          print('Length  ${addMoreQuestion.length}' );
          final api = ApiController();
          final bool ans = await api.addMoreQuestionToTest(addMoreQuestion,widget.id, context);
          if(ans){
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TestDetailPage(id:widget.id,)));
          }
        }
      }, label:const Text('Add Selected Question To Test',style:TextStyle(color: Colors.black,fontSize: 15),),icon:Icon(Icons.add_box_rounded,size: 35,color: Colors.cyan.shade600,),style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade100,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),minimumSize: const Size(250,60))),
      appBar: AppBar(
        title: const Text('Question Bank'),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.clear),
            tooltip: 'Clear',
            style: IconButton.styleFrom(
              hoverColor: Colors.green,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFilterCard(),
              const SizedBox(height: 20),
              if (filteredQuestions != null)
                ...filteredQuestions!.map((question) => _buildQuestionCard(question, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      color: Colors.blue.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdown('Select Question Type', questionType, questionTypes),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[100],
        enabled: true,
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.cyan)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.cyan)),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          questionType = newValue;
        });
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              if (questionType == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a question type before searching.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              } else {
                try {
                  final response = await fetchFilteredQuestions(questionType!,widget.id);
                  setState(() {
                    filteredQuestions = response.filteredQuestions;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            label: Text('SEARCH', style: AppTextStyles.body(color: Colors.white)),
            icon: const Icon(Icons.search_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<FilteredQuestionsResponse> fetchFilteredQuestions(String questionType,int id) async {
    final url = Uri.parse('https://aravind10.pythonanywhere.com/Test/$id/add-questions/');
    final response = await http.get(url.replace(queryParameters: {'question_type': matchType(questionType)}));
    if (response.statusCode == 200) {
      return FilteredQuestionsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch filtered questions');
    }
  }
  
  String matchType(String questionType){
    switch(questionType){
    case 'MCQ':
      return 'MCQ';
    case 'True/False':
      return 'TF';
    case 'Fill in the Blanks':
      return 'FIBL';
    case 'Multi Correct MCQ':
      return 'MAMCQ';
    case 'Match The Following':
      return 'MTF';
      default: return 'Everything';
    }
  }

  Widget _buildQuestionCard(FilteredQuestionModel question, BuildContext context) {
    bool isAdded = addMoreQuestion.contains(question.id);

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
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton.icon(
            onPressed: () {
              toggleAddButton(question);
            },
            label: Text(
              isAdded ? 'Remove' : 'Add',
              style:const TextStyle(color: Colors.black),
            ),
            icon: Icon(
              isAdded ? Icons.remove_circle_outline : Icons.add_comment_rounded,
              color: isAdded ? Colors.red : Colors.green,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdded ? Colors.redAccent.shade100 : Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
  }

  void toggleAddButton(FilteredQuestionModel question) {

    setState(() {
      if (addMoreQuestion.contains(question.id)) {
        addMoreQuestion.remove(question.id);
      } else {
        addMoreQuestion.add(question.id);
      }
      print(addMoreQuestion);
    });
  }
  Widget _buildCard({
    required String title,
    required List<Widget> details,
    required BuildContext context,
    required String type,
    required FilteredQuestionModel question,
  }) {
    return InkWell(
      onTap: () {
        switch (question.questionType) {
          case 'FIBL':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPageFillInTheBlanks(
                  questionText: question.questionText,
                  description: question.description,
                  mark: question.marks,
                  negativeMark: -1,
                  correctAnswers: [(question.answer as FilteredFillUpsAnswerModel).answer],
                ),
              ),
            );
            break;
          case 'MCQ':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleCorrectQuestions(
                  questionText: question.questionText,
                  description: question.description,
                  marks: question.marks,
                  negativeMark: -1,
                  choices: (question.answer as FilteredSingleChoiceAnswerModel).choices,
                  correctAnswer: (question.answer as FilteredSingleChoiceAnswerModel).correctAnswer,
                ),
              ),
            );
            break;
          case 'MTF':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchTheFollowingQuestion(
                  questionText: question.questionText,
                  pairs: (question.answer as FilteredMatchAnswerModel).pairs,
                  description: question.description,
                  mark: question.marks,
                  negativeMark: -1,
                ),
              ),
            );
            break;
          case 'MAMCQ':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionDetailScreen(
                  questionText: question.questionText,
                  description: question.description,
                  marks: question.marks,
                  negativeMark: -1,
                  choices: (question.answer as FilteredMultipleChoiceAnswerModel).choices,
                  correctAnswers: (question.answer as FilteredMultipleChoiceAnswerModel).correctAnswers,
                ),
              ),
            );
            break;
          case 'TF':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrueFalseQuestionDetail(
                  title: question.questionText,
                  description: question.description,
                  marks: question.marks,
                  negativeMarks: -1,
                  correctAnswer: (question.answer as FilteredTFAnswerModel).correctAnswer,
                ),
              ),
            );
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
        Icon(icon, size: 18,color: Colors.cyan),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $value',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,

            ),
          ),
        ),
      ],
    );
  }
}