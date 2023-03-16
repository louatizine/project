import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController{
  // @override
  // void onReady(){
  //   super.onReady();
  // }
  var taskList = <Task>[].obs;

  Future<void> addTask({Task? task}) async {
    await DBhelper.insert(task);
  }

//get all the data from the table
void getTasks() async {
   List<Map <String,dynamic> > tasks = await DBhelper.query();
   taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
}

void delete(Task task){
   DBhelper.delete(task);
   getTasks();
}
void markTaskCompleted(int id )async{
   await DBhelper.update(id);
   getTasks();
}
}