import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/controllers/data_controller.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/services/service.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/task_widget.dart';
import 'package:get/get.dart';

class AllZone extends StatelessWidget {
  const AllZone({
    Key? key,
  }) : super(key: key);
  _loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.find<DataController>().myData.length);
    _loadData();
    List myData = ["Zona Segura Nro 1", "Zona Segura Nro 2"];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
    );
    final rightEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      alignment: Alignment.centerRight,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 60),
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: (() {
              Get.back() // Get.to(() => HomeScreen(),
                  //     transition: Transition.fade, duration: Duration(seconds: 1));
                  ;
            }),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.secondaryColor,
            ),
          ),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height / 3.2,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.scaleDown, image: AssetImage("assets/header1.jpg")),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Row(children: [
            Icon(
              Icons.home,
              color: AppColors.secondaryColor,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.5),
                  color: Colors.black54),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.calendar_month,
              color: AppColors.secondaryColor,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "2",
              style: TextStyle(fontSize: 20, color: AppColors.secondaryColor),
            )
          ]),
        ),
        Flexible(
            child: ListView.builder(
                itemCount: myData.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: leftEditIcon,
                    secondaryBackground: rightEditIcon,
                    onDismissed: (DismissDirection direction) {
                      print("after dismiss");
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2e3253)
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ButtonWidget(
                                          backgroundcolor: AppColors.mainColor,
                                          text: "Ver detalle de la Zona",
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ButtonWidget(
                                          backgroundcolor: AppColors.mainColor,
                                          text:
                                              "Actualizar el registro de la Zona",
                                          textColor: Colors.white,
                                        )
                                      ],
                                    ),
                                  ));
                            });
                        return false;
                      } else {
                        return Future.delayed(const Duration(seconds: 1),
                            () => direction == DismissDirection.endToStart);
                      }
                    },
                    key: ObjectKey(index),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: TaskWidget(
                        text: myData[
                            index], //controller.myData[index]["get_task"],
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                }))
      ]),
    );
  }
}
