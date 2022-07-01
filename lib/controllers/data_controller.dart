import 'package:flutter_golang_yt/services/service.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;

  Future<void> getData() async {
    Response response = await service.getData();
    if (response.statusCode == 200) {
      _myData = response.body;
      print("Nos llego la data");
      update();
    } else {
      print("we did not get the fucking datadadad");
    }
  }

  Future<void> postData(String task, String taskDetail) async {
    _isLoading = true;
    Response response =
        await service.postData({"task_name": task, "task_detail": taskDetail});
    if (response.statusCode == 200) {
      update();
      print("data post sucesstull");
    } else {
      print("data post failed");
    }
  }
}
