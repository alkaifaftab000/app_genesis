// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class MatchTheFollowingScreen extends StatefulWidget {
  const MatchTheFollowingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MatchTheFollowingScreenState createState() =>
      _MatchTheFollowingScreenState();
}

class _MatchTheFollowingScreenState extends State<MatchTheFollowingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctMarksController =
      TextEditingController(text: '1');
  final TextEditingController _wrongMarksController =
      TextEditingController(text: '0');

  List<Map<String, dynamic>> pairs = List.generate(2, (_) => _createNewPair());

  static Map<String, dynamic> _createNewPair() => {
        'left': TextEditingController(),
        'right': TextEditingController(),
        'leftImage': null,
        'rightImage': null
      };

  Future<void> _pickImage(int index, String side) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pairs[index]['${side}Image'] = File(pickedFile.path);
      });
    }
  }

  void _addPair() => setState(() => pairs.add(_createNewPair()));

  void _removePair(int index) {
    if (pairs.length > 2) {
      setState(() => pairs.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match the Following'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildQuestionField(),
            const SizedBox(height: 20),
            ..._buildPairFields(),
            _buildAddPairButton(),
            const SizedBox(height: 20),
            _buildMarksFields(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
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

  List<Widget> _buildPairFields() {
    return pairs.asMap().entries.map((entry) {
      int index = entry.key;
      var pair = entry.value;
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildItemField(pair, 'left', index)),
              const SizedBox(width: 10),
              Expanded(child: _buildItemField(pair, 'right', index)),
            ],
          ),
          if (pairs.length > 2)
            TextButton(
              onPressed: () => _removePair(index),
              child: const Text('Remove Pair',
                  style: TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  Widget _buildItemField(Map<String, dynamic> pair, String side, int index) {
    return Column(
      children: [
        TextFormField(
          controller: pair[side],
          decoration: InputDecoration(
            labelText: "${side.capitalize()} Item ${index + 1}",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.image),
              onPressed: () => _pickImage(index, side),
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? "Field can't be empty" : null,
        ),
        if (pair['${side}Image'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.file(pair['${side}Image'], height: 100),
          ),
      ],
    );
  }

  Widget _buildAddPairButton() {
    return TextButton.icon(
      onPressed: _addPair,
      icon: const Icon(Icons.add),
      label: const Text('Add Pair'),
    );
  }

  Widget _buildMarksFields() {
    return Row(
      children: [
        Expanded(
            child: _buildMarksField(_correctMarksController, 'Correct marks')),
        const SizedBox(width: 10),
        Expanded(child: _buildMarksField(_wrongMarksController, 'Wrong marks')),
      ],
    );
  }

  Widget _buildMarksField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? "Marks can't be empty" : null,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('Submit', style: TextStyle(fontSize: 18)),
    );
  }

  // ... (previous code remains the same)

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final ac = ApiController();

      // Create pairs as a Map with letter keys
      Map<String, String> pairsData = {};
      for (int i = 0; i < pairs.length; i++) {
        String key = String.fromCharCode(65 + i); // A, B, C, ...
        pairsData[key] = pairs[i]['right'].text;
      }

      Map<String, dynamic> apiData = {
        "match_the_following_question": {
          "pairs": pairsData,
        },
        "question_text": _questionController.text,
        "question_type": "MTF", // Match The Following
        "marks": int.parse(_correctMarksController.text),
        "negative_marks": int.parse(_wrongMarksController.text),
        "description": "Match the following items",
        "is_public": true,
        "course": 1, // Assuming a default course ID, adjust as needed
        "created_by": 1, // Assuming a default user ID, adjust as needed
      };

      if (kDebugMode) {
        print(apiData);
      }

      try {
        // Handling image uploads
        for (int i = 0; i < pairs.length; i++) {
          if (pairs[i]['leftImage'] != null) {
            String? leftImageUrl = await _uploadImage(pairs[i]['leftImage']);
            if (leftImageUrl != null) {
              apiData["match_the_following_question"]["left_image_$i"] =
                  leftImageUrl;
            }
          }
          if (pairs[i]['rightImage'] != null) {
            String? rightImageUrl = await _uploadImage(pairs[i]['rightImage']);
            if (rightImageUrl != null) {
              apiData["match_the_following_question"]["right_image_$i"] =
                  rightImageUrl;
            }
          }
        }

        // Sending data to API
        await ac.addQuestion(apiData, context);
        if (context.mounted) {
          Utility.toastMessage('Question Added', context,
              ToastificationType.success, ToastificationStyle.minimal);
        }
      } catch (error) {
        if (context.mounted) {
          Utility.toastMessage(error.toString(), context,
              ToastificationType.error, ToastificationStyle.minimal);
        }
      }
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    // Implement image upload logic here
    // This should return the URL of the uploaded image
    // For now, we'll just return a placeholder URL
    return 'https://example.com/placeholder-image.jpg';
  }

// ... (rest of the code remains the same)
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
