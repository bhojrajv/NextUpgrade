import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_upgrade/Model/TaskModel.dart';
import 'package:next_upgrade/View/Task_Screen.dart';
import 'package:next_upgrade/ViewModel/controller/Login_Controller.dart';
import 'package:next_upgrade/ViewModel/controller/Task_Controller.dart';

class TaskList extends StatelessWidget {
  final String? userid;
  final List<TaskModel> tasks;

  TaskList({required this.tasks,this.userid});

  @override
  Widget build(BuildContext context) {
    TaskController _taskcontr=Get.put(TaskController());
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 2,
            child: InkWell(
              onTap: (){
               Get.to(()=>TaskScreen(title: "Update Task",
               taskid: tasks[index].uid,des: tasks[index].description,));
              },
              child: ListTile(
                title: Text(tasks[index].description),
                leading: Checkbox(
                  value: tasks[index].isComplete,
                  onChanged: (value)async {
                     _taskcontr.isToggle(flg: tasks[index].isComplete);
                   await _taskcontr.updateTask(taskid:tasks[index].uid,uid: userid,
                        status: _taskcontr.isComplete.value,
                   desc: tasks[index].description);
                   if(_taskcontr.isComplete==true){
                     Get.showSnackbar(GetSnackBar(message: 'Task status:Complete',));
                   }
                    // Implement logic to update task completion status
                  },
                ),
                trailing: InkWell(onTap: ()async{
                 await _taskcontr.deleteTask(uid: _taskcontr.user?.uid,taskid: tasks[index].uid);
                 Get.showSnackbar(GetSnackBar(isDismissible: true,message: "task deleted",));
                },
                    child: Icon(Icons.delete,color: Colors.red,)),
              ),
            ),
          ),
        );
      },
    );
  }
}
