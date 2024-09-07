// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class MultiCorrectMcqScreen extends StatefulWidget {
  const MultiCorrectMcqScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MultiCorrectMcqScreenState createState() => _MultiCorrectMcqScreenState();
}

class _MultiCorrectMcqScreenState extends State<MultiCorrectMcqScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctMarksController =
      TextEditingController(text: '1');
  final TextEditingController _wrongMarksController =
      TextEditingController(text: '0');
  List<Map<String, dynamic>> options = [
    {'text': TextEditingController(), 'image': null, 'isCorrect': false},
    {'text': TextEditingController(), 'image': null, 'isCorrect': false},
  ];

  bool _isPublic = false;

  Future<void> _pickImage(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        options[index]['image'] = File(pickedFile.path);
      }
    });
  }

  void _addOption() {
    setState(() {
      options.add(
          {'text': TextEditingController(), 'image': null, 'isCorrect': false});
    });
  }

  void _removeOption(int index) {
    setState(() {
      if (options.length > 2) {
        options.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Answer Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: "Type your question",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: options[index]['isCorrect'],
                            onChanged: (bool? value) {
                              setState(() {
                                options[index]['isCorrect'] = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: options[index]['text'],
                              decoration: InputDecoration(
                                labelText:
                                    "Option ${String.fromCharCode(65 + index)}",
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.image),
                                  onPressed: () => _pickImage(index),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (options[index]['image'] != null)
                        Image.file(
                          options[index]['image'],
                          height: 150,
                        ),
                      const SizedBox(height: 10),
                      if (options.length > 2)
                        TextButton(
                          onPressed: () => _removeOption(index),
                          child: const Text('Remove Option',
                              style: TextStyle(color: Colors.red)),
                        ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
              TextButton(
                onPressed: _addOption,
                child: const Text('Add Option'),
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
              const SizedBox(height: 20),
              Center(
                  child: TextButton.icon(
                onPressed: submitQuestion,
                label: const Text('Confirm'),
                icon: const Icon(Icons.question_answer_rounded),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void submitQuestion() async {
    final ac = ApiController();
    if (_questionController.text.isEmpty ||
        !options.any((option) => option['isCorrect'])) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please fill all fields and select at least one correct option'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
        ),
      );
      return;
    }

    // Create choices as a Map with letter keys
    Map<String, String> choices = {};
    List<String> correctAnswers = [];

    for (int i = 0; i < options.length; i++) {
      String key = String.fromCharCode(65 + i); // A, B, C, ...
      choices[key] = options[i]['text'].text;

      if (options[i]['isCorrect']) {
        correctAnswers.add(key);
      }
    }

    Map<String, dynamic> apiData = {
      "multiple_answer_question": {
        "choices": choices,
        "correct_answers": correctAnswers,
      },
      "question_text": _questionController.text,
      "question_type": "MAMCQ",
      "description": "Hello",
      "marks": int.parse(_correctMarksController.text),
      "is_public": _isPublic,
      "course": 1,
      "created_by": 1,
    };

    if (kDebugMode) {
      print(apiData);
    }

    await ac.addQuestion(apiData, context).then((onValue) {
      if (context.mounted) {
        Utility.toastMessage('Added', context, ToastificationType.success,
            ToastificationStyle.minimal);
      }
    }).onError((error, stackTrace) {
      if (context.mounted) {
        Utility.toastMessage(error.toString(), context,
            ToastificationType.error, ToastificationStyle.minimal);
      }
    });
  }
}
