

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_upgrade/Model/TaskModel.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  //to save task descrition
  Future<void> addTask({required String uid, required String description,
    bool? isComplete}) async {
    try {
      if (user != null) {
        debugPrint("uid:${user?.uid}/$uid");
        await _firestore.collection('tasks').doc(uid).collection(
            'userTasks').add({
          'description': description,
          'isComplete': isComplete ?? false,
        });
      } else {
        Get.showSnackbar(GetSnackBar(message: "user is $user",));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(message: "Error:${e.toString()}",));
      debugPrint("Error adding task: $e");
    }
  }

  //to fetch tasks list
  List<QuerySnapshot<Map<String, dynamic>>> task_list = <
      QuerySnapshot<Map<String, dynamic>>>[].obs;
  List<TaskModel>task_list2 = <TaskModel>[].obs;

  Future<void> fetchTask() async {
    var res = await _firestore.collection('tasks').doc(user?.uid).collection(
        "userTasks")
        .snapshots();
    task_list = await res.toList();
  }
  // toggle task status
  var isComplete=false.obs;
  void isToggle({bool?flg}){
    isComplete.value=!flg!;
    update();
  }
//to update task description and status
  Future<void>updateTask({String?uid,String?taskid,String?desc,bool?status})async{
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('userTasks')
          .doc(taskid??"")
          .update({'description': desc,"isComplete":status});
      //debugPrint('Task description updated successfully.');
    } catch (e) {
      debugPrint('Error updating task description: $e');
    }
  }
  //to delete task
Future<void>deleteTask({String?uid,String?taskid})async{
  try {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('userTasks')
        .doc(taskid??"")
        .delete();
    //debugPrint('Task description updated successfully.');
  } catch (e) {
    debugPrint('Error deleting task description: $e');
  }
}
}