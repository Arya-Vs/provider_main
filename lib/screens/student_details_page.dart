import 'dart:io';
import 'package:db2/provider/student_provider.dart';
import 'package:db2/screens/student_list_page.dart';
import 'package:flutter/material.dart';
import 'package:db2/screens/edit_student_page.dart';
import 'package:db2/model/student_model.dart';
import 'package:db2/db/database_helper.dart';
import 'package:provider/provider.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  StudentDetailPage({required this.student});
  DatabaseHelper db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Student Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Student'),
                  content:
                      Text('Are you sure you want to delete ${student.name}?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black
                      ),
                      child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black
                      ),
                      child: const Text('Delete',style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        studentProvider.deleteStudent(student.id);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => StudentList()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStudentPage(student: student),
                ),
              ).then((_) => Navigator.pop(context));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: FileImage(File(student.profilePicturePath)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Name: ${student.name}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Age: ${student.age}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Gender: ${student.gender}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Rollnumber: ${student.rollnumber}',
              style: const TextStyle(fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
