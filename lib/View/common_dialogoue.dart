import 'package:flutter/material.dart';
import 'package:get/get.dart';

showDialogueBox({context,String?mssage}){
  showDialog(context: context, builder: (contx){
    return AlertDialog(
          content: Container(
            width: Get.width/2,
            height: Get.height/8,
            child: Column(
              children: [
                Text("$mssage",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
      actions: [InkWell(onTap: (){
        Get.back();
      }, child: Text("Ok",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),)],
    );
  });
}