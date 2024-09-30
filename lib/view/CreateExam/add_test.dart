import 'package:flutter/material.dart';
import 'package:app_genesis/Backend/api_controller.dart';
import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:app_genesis/utils/fonts.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({super.key});

  @override
  ExamDetailsScreenState createState() => ExamDetailsScreenState();
}

class ExamDetailsScreenState extends State<ExamDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _shuffleQuestions = true;
  bool _shuffleOptions = true;
  final TextEditingController _examNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  @override
  void dispose() {
    _examNameController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Exam Details',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_rounded, color: Colors.black),
            onPressed: () {
              // Implement delete functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCard(
                  title: 'Exam Information',
                  child: Column(
                    children: [
                      _buildTextFormField(
                        controller: _examNameController,
                        label: 'Exam Name',
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter an exam name' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _durationController,
                        label: 'Duration (minutes)',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter a duration' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _topicController,
                        label: 'Topic',
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter a Topic' : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  title: 'Exam Settings',
                  child: Column(
                    children: [
                      _buildSwitchListTile(
                        title: 'Shuffle Questions',
                        value: _shuffleQuestions,
                        onChanged: (value) =>
                            setState(() => _shuffleQuestions = value),
                      ),
                      _buildSwitchListTile(
                        title: 'Shuffle Options',
                        value: _shuffleOptions,
                        onChanged: (value) =>
                            setState(() => _shuffleOptions = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  title: 'Exam Details',
                  child: Column(
                    children: [
                      _buildTextFormField(
                        controller: _descriptionController,
                        label: 'Exam Description',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _instructionsController,
                        label: 'Exam Instructions (optional)',
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.cyan,
                  ),
                  icon: const Icon(Icons.save_outlined, color: Colors.white),
                  label: Text('Confirm', style: AppTextStyles.body()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      elevation: 4,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.heading(color: Colors.black)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        enabled: true,
        enabledBorder:UnderlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.cyan) ),
        focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.green)),
        errorBorder:UnderlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.cyan) ),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.cyan)),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.cyan,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final api = ApiController();
      final data = {
        "title": _examNameController.text,
        "topic": _topicController.text,
        "duration":_durationController.text,
        "description": _descriptionController.text,
        "instructions": _instructionsController.text,
        "created_by": 1,

      };

      try {
        bool success = await api.createTest(data, context);
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Teacher()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating exam: $e')),
        );
      }
    }
  }
}