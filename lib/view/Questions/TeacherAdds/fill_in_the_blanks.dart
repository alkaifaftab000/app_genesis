import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/utils/utility.dart';
import 'package:toastification/toastification.dart';

class FillInTheBlanksScreen extends StatefulWidget {
  const FillInTheBlanksScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FillInTheBlanksScreenState createState() => _FillInTheBlanksScreenState();
}

class _FillInTheBlanksScreenState extends State<FillInTheBlanksScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiController _apiController = ApiController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctMarksController =
      TextEditingController(text: '1');
  final TextEditingController _wrongMarksController =
      TextEditingController(text: '0');
  final TextEditingController _explanationController = TextEditingController();
  final List<TextEditingController> _blankControllers = [
    TextEditingController()
  ];

  bool _isPublic = false;
  File? _questionImage;

  Future<void> _pickQuestionImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _questionImage = File(pickedFile.path));
    }
  }

  void _addBlank() =>
      setState(() => _blankControllers.add(TextEditingController()));

  void _removeBlank(int index) {
    if (_blankControllers.length > 1) {
      setState(() => _blankControllers.removeAt(index));
    }
  }

  Future<void> _submitQuestion() async {
    if (_formKey.currentState!.validate()) {
      final String answer =
          _blankControllers.map((c) => c.text.trim()).join(' ');
      final Map<String, dynamic> data = {
        "fill_in_the_blank_question": {"answer": answer},
        "question_text": _questionController.text.trim(),
        "question_type": "FIBL",
        "description": _explanationController.text.trim(),
        "marks": int.parse(_correctMarksController.text.trim()),
        "is_public": _isPublic,
        "course": 1,
        "created_by": 1
      };

      final bool success = await _apiController.addQuestion(data, context);
      if (context.mounted) {
        Utility.toastMessage(
            success ? 'Added' : 'Failed',
            // ignore: use_build_context_synchronously
            context,
            ToastificationType.success,
            ToastificationStyle.simple);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill in the Blanks')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildQuestionField(),
              const SizedBox(height: 16),
              _buildQuestionImage(),
              const SizedBox(height: 16),
              ..._buildBlankFields(),
              _buildAddBlankButton(),
              const SizedBox(height: 16),
              _buildExplanationField(),
              const SizedBox(height: 16),
              _buildPublicCheckbox(),
              const SizedBox(height: 16),
              _buildMarksFields(),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionField() {
    return TextFormField(
      controller: _questionController,
      decoration: InputDecoration(
        labelText: "Type your sentence with blanks",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.image),
          onPressed: _pickQuestionImage,
        ),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? "Question can't be empty" : null,
    );
  }

  Widget _buildQuestionImage() {
    return _questionImage != null
        ? Image.file(_questionImage!, height: 100)
        : const SizedBox.shrink();
  }

  List<Widget> _buildBlankFields() {
    return _blankControllers.asMap().entries.map((entry) {
      final int index = entry.key;
      final TextEditingController controller = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Blank ${index + 1}",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? "Blank can't be empty" : null,
              ),
            ),
            if (_blankControllers.length > 1)
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => _removeBlank(index),
              ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAddBlankButton() {
    return TextButton.icon(
      onPressed: _addBlank,
      icon: const Icon(Icons.add),
      label: const Text('Add Blank'),
    );
  }

  Widget _buildExplanationField() {
    return TextFormField(
      controller: _explanationController,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Explanation',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPublicCheckbox() {
    return Row(
      children: [
        const Text('Post this Question as Public:'),
        Checkbox(
          value: _isPublic,
          onChanged: (bool? value) =>
              setState(() => _isPublic = value ?? false),
        ),
      ],
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
      onPressed: _submitQuestion,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Confirm',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
