import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'fill_in_the_blanks.dart';
import 'match_the_following.dart';
import 'mcq.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'multi_correct_mcq.dart';

class TrueFalseScreen extends StatefulWidget {
  const TrueFalseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrueFalseScreenState createState() => _TrueFalseScreenState();
}

class _TrueFalseScreenState extends State<TrueFalseScreen> {
  final ac = ApiController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();
  final TextEditingController _correctMarksController =
      TextEditingController(text: '1');
  final TextEditingController _wrongMarksController =
      TextEditingController(text: '0');

  String _selectedOption = '';
  bool _isCorrectSelected = false;
  bool _isPublic = false;
  String _selectedType = 'True or False';
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const Teacher()));
            }, icon:const Icon(Icons.arrow_back_ios_new_rounded)),
            const SizedBox(width: 10),
            const Text('Create Question'),
          ]
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: "Type your question",
                  border: const OutlineInputBorder(),
                  errorText: _isCorrectSelected ? null : "Can't be empty",
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                ),
                value: _selectedType,
                items: [
                  'True or False',
                  'MCQ',
                  'Match the following',
                  'Fill in the blanks',
                  'Multiple answer Question'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                    if (_selectedType == 'MCQ') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const McqScreen()),
                      );
                    } else if (_selectedType == 'Match the following') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MatchTheFollowingScreen()),
                      );
                    } else if (_selectedType == 'Fill in the blanks') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FillInTheBlanksScreen()),
                      );
                    } else if (_selectedType == 'Multiple answer Question') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MultiCorrectMcqScreen()),
                      );
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              RadioListTile<String>(
                title: const Text('True'),
                value: 'True',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value!;
                    _isCorrectSelected = true;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('False'),
                value: 'False',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value!;
                    _isCorrectSelected = true;
                  });
                },
              ),
              if (!_isCorrectSelected)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Please select the correct answer',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              TextField(
                controller: _explanationController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Explanation",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _pickImage,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (_image != null)
                Image.file(
                  _image!,
                  height: 150,
                ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Post this Question as Public : '),
                Checkbox(
                  value: _isPublic,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                )
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _correctMarksController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Correct marks',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _wrongMarksController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Wrong marks',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () async {
                    if (_questionController.text.isEmpty ||
                        !_isCorrectSelected) {
                      setState(() {
                        _isCorrectSelected = false;
                      });
                    } else {
                      if (kDebugMode) {
                        print("Question: ${_questionController.text}");
                        print("Answer: $_selectedOption");
                        print("Explanation: ${_explanationController.text}");
                        print("Correct Marks: ${_correctMarksController.text}");
                        print("Wrong Marks: ${_wrongMarksController.text}");
                        print("Is Public : $_isPublic");
                        if (_image != null) {
                          print("Image Path: ${_image!.path}");
                        }

                        Map<String, dynamic> data = {
                          "true_or_false_question": {
                            "correct_answer": _selectedOption
                          },
                          "question_text":
                              _questionController.text.toString().trim(),
                          "question_type": "TF",
                          "description":
                              _explanationController.text.toString().trim(),
                          "marks": int.parse(
                              _correctMarksController.text.toString().trim()),
                          "is_public": _isPublic,
                          "course": 1,
                          "created_by": 1
                        };

                        final ans = await ac.addQuestion(data, context);
                        if (ans) {
                          if (context.mounted) {
                            Utility.toastMessage(
                                'Added',
                                context,
                                ToastificationType.info,
                                ToastificationStyle.minimal);
                          }
                        } else {
                          if (context.mounted) {
                            Utility.toastMessage(
                                'Failed',
                                context,
                                ToastificationType.error,
                                ToastificationStyle.minimal);
                          }
                        }
                      }
                    }
                  },
                  label: const Text('Confirm'),
                  icon: const Icon(Icons.confirmation_num_rounded),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
