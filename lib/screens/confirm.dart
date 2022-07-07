import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/widgets/cardinfo.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return cardInfo("");
  }
}

Widget Cards() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
    ),
  );
}
