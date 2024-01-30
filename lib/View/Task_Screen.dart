import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:next_upgrade/View/Home_Screen.dart';
import 'package:next_upgrade/ViewModel/controller/Login_Controller.dart';
import 'package:next_upgrade/ViewModel/controller/Task_Controller.dart';

class TaskScreen extends StatefulWidget {
  final String?title;
  final String? taskid;
  final String? des;
  const TaskScreen({this.title,this.taskid,this.des,Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final LoginController _loginControcller=Get.put(LoginController());
  final TaskController _taskController=Get.put(TaskController());
  final TextEditingController _descriptionController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
  _descriptionController.text=widget.des??'';
  _loginControcller.getUserprofile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title??'Create Task'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                maxLines: 5,
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Task Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ), ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                  if(_descriptionController.text.trim().isEmpty){
                    Get.showSnackbar(GetSnackBar(message: "Please enter description",));
                  }else{
                   if(widget.title==null || widget.title==''){
                     await _taskController.addTask(uid: _loginControcller.getProfile.uid??"", description: _descriptionController.text,
                         isComplete: false);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                     =>HomeScreen()));
                     Get.showSnackbar(GetSnackBar(message: "Description Saved",
                       duration: Duration(seconds: 4),));
                   }else{
                     await _taskController.updateTask(uid: _loginControcller.getProfile.uid??"", desc: _descriptionController.text,
                       status: false,taskid: widget.taskid);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                   =>HomeScreen()));

                   }
                  }
                  // Implement code to add a new task to Firebase
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
