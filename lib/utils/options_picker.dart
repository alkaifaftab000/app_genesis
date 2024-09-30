import 'package:app_genesis/view/CreateExam/from_question_bank.dart';
import 'package:app_genesis/view/Questions/TeacherAdds/true_false.dart';
import 'package:flutter/material.dart';
class OptionPicker{

  Future<void> showQuestionPicker(BuildContext context,int id) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade50, // Set background color
      shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)), // Rounded top corners
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0), // Padding around the content
            child: Wrap(
              children: <Widget>[
                _buildListTile(
                  icon: Icons.add,
                  title: 'Add your own question',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const TrueFalseScreen()),
                    );
                  },
                ),
                _buildListTile(
                  icon: Icons.library_books,
                  title: 'Bulk Upload your questions',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                _buildListTile(
                  icon: Icons.upload_file,
                  title: 'Add Questions from bank',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FromQuestionBank(id: id)),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      color: Colors.blue.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Space between cards
      elevation: 4, // Shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners for the card
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black), // Custom icon color
        title: Text(title, style: const TextStyle(color: Colors.black)), // Custom text color
        onTap: onTap,
      ),
    );
  }
}