import 'package:flutter/material.dart';

class TodaySale extends StatefulWidget {
  const TodaySale({Key? key}) : super(key: key);

  @override
  State<TodaySale> createState() => _TodaySaleState();
}

class _TodaySaleState extends State<TodaySale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "No Sales!!!",
        style: TextStyle(
          fontSize: 19,
        ),
      )),
    );
  }
}
