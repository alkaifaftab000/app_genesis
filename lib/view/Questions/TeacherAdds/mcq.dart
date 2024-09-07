// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class McqScreen extends StatefulWidget {
  const McqScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _McqScreenState createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctMarksController =
      TextEditingController(text: '1');
  final TextEditingController _wrongMarksController =
      TextEditingController(text: '0');
  String _selectedCorrectOption = '';
  List<Map<String, dynamic>> options = List.generate(
    2,
    (_) => {'text': TextEditingController(), 'image': null},
  );

  Future<void> _pickImage(int index) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => options[index]['image'] = File(pickedFile.path));
    }
  }

  void _addOption() => setState(
      () => options.add({'text': TextEditingController(), 'image': null}));

  void _removeOption(int index) {
    if (options.length > 2) {
      setState(() {
        options.removeAt(index);
        if (_selectedCorrectOption ==
            'Option ${String.fromCharCode(65 + index)}') {
          _selectedCorrectOption = '';
        }
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final ac = ApiController();

      // Create choices as a Map with letter keys
      Map<String, String> choices = {};
      String correctAnswer = '';

      for (int i = 0; i < options.length; i++) {
        String key = String.fromCharCode(65 + i); // A, B, C, ...
        choices[key] = options[i]['text'].text;

        if ('Option $key' == _selectedCorrectOption) {
          correctAnswer = key;
        }
      }

      Map<String, dynamic> apiData = {
        "multiple_choice_question": {
          "choices": choices,
          "correct_answers": correctAnswer,
        },
        "question_text": _questionController.text,
        "question_type": "MCQ",
        "marks": int.parse(_correctMarksController.text),
        "description": "Helo",
        "is_public": true,
        "course": 1,
        "created_by": 1,
      };

      if (kDebugMode) {
        print(apiData);
      }

      try {
        await ac.addQuestion(apiData, context);

        Utility.toastMessage('Question Added', context,
            ToastificationType.success, ToastificationStyle.minimal);
      } catch (error) {
        if (context.mounted) {
          Utility.toastMessage(error.toString(), context,
              ToastificationType.error, ToastificationStyle.minimal);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MCQ Question')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildQuestionField(),
            const SizedBox(height: 20),
            ..._buildOptionFields(),
            _buildAddOptionButton(),
            const SizedBox(height: 20),
            _buildCorrectOptionDropdown(),
            const SizedBox(height: 20),
            _buildMarksFields(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const SizedBox(height: 20),
            // _buildRemoveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionField() {
    return TextFormField(
      controller: _questionController,
      decoration: const InputDecoration(
        labelText: "Type your question",
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? "Question can't be empty" : null,
    );
  }

  List<Widget> _buildOptionFields() {
    return options.asMap().entries.map((entry) {
      final int index = entry.key;
      final option = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: option['text'],
            decoration: InputDecoration(
              labelText: "Option ${String.fromCharCode(65 + index)}",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.image),
                onPressed: () => _pickImage(index),
              ),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? "Option can't be empty" : null,
          ),
          if (option['image'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.file(option['image'], height: 100),
            ),
          if (options.length > 2)
            TextButton(
              onPressed: () => _removeOption(index),
              child: const Text('Remove Option',
                  style: TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget _buildAddOptionButton() {
    return TextButton.icon(
      onPressed: _addOption,
      icon: const Icon(Icons.add),
      label: const Text('Add Option'),
    );
  }

  Widget _buildCorrectOptionDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Correct Option",
        border: OutlineInputBorder(),
      ),
      value: _selectedCorrectOption.isEmpty ? null : _selectedCorrectOption,
      items: options.asMap().entries.map((entry) {
        int idx = entry.key;
        return DropdownMenuItem<String>(
          value: 'Option ${String.fromCharCode(65 + idx)}',
          child: Text('Option ${String.fromCharCode(65 + idx)}'),
        );
      }).toList(),
      onChanged: (String? newValue) =>
          setState(() => _selectedCorrectOption = newValue!),
      validator: (value) =>
          value == null ? 'Please select the correct option' : null,
    );
  }

  Widget _buildMarksFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _correctMarksController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Correct marks',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? "Correct marks required" : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _wrongMarksController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Wrong marks',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? "Wrong marks required" : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Confirm',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  // Widget _buildRemoveButton() {
  //   return TextButton(
  //     onPressed: () {
  //       // Logic to remove the MCQ form
  //     },
  //     child: const Text('Remove', style: TextStyle(color: Colors.red)),
  //   );
  // }
}
