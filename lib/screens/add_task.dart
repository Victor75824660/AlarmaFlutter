import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/controllers/data_controller.dart';
import 'package:flutter_golang_yt/screens/all_tasks.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/textfield_widget.dart';
import 'package:get/get.dart';

import '../widgets/error_warning_ms.dart';

class AddZone extends StatelessWidget {
  const AddZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    bool _dataValidation() {
      if (nameController.text.trim() == '') {
        Message.taskErrorOrWarning("Nota", "Nombre de la nota esta vacio");
        return false;
      } else if (detailController.text.trim() == '') {
        Message.taskErrorOrWarning(
            "Detalle de Nota", "Necesias poner algun detalle de tu nota");
        return false;
      } else if (nameController.text.length <= 10) {
        Message.taskErrorOrWarning(
            "Nota", "La nota necesita un titulo con mas de 10 caracteres");
        return false;
      } else if (detailController.text.length < 10) {
        Message.taskErrorOrWarning(
            "Cuerpo", "El cuerpo de tu nota necesita mas de 10 caracteres");
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/addtask1.jpg"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              SizedBox(
                height: 40,
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                  ))
            ]),
            Column(
              children: [
                TextFieldWidget(
                    textController: nameController,
                    hintText: "titulo de tu Nota",
                    borderRadius: 30),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  textController: detailController,
                  hintText: "Cuerpo de tu Nota",
                  borderRadius: 15,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_dataValidation()) {
                      Get.find<DataController>().postData(
                          nameController.text.trim(),
                          detailController.text.trim());
                      Get.to(
                        () => AllZone(),
                        transition: Transition.circularReveal,
                      );
                    }
                  },
                  child: ButtonWidget(
                      backgroundcolor: AppColors.mainColor,
                      text: "Registrar tu Nota",
                      textColor: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            )
          ],
        ),
      ),
    );
  }
}
