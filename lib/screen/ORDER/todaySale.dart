import 'package:flutter/material.dart';

class TodaySale extends StatefulWidget {
  const TodaySale({Key? key}) : super(key: key);

  @override
  State<TodaySale> createState() => _TodaySaleState();
}

class _TodaySaleState extends State<TodaySale> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height * 0.7,
      width: double.infinity,
      child: Center(
          child: Text(
        "No Sales!!!",
        style: TextStyle(
          fontSize: 19,
        ),
      )),
    ));
=======
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
                height: size.height * 0.7,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "No Sales!!!",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                )),
              )
    );
>>>>>>> 31623e8790e54a2954aaf888e8ffbd7a882c322f
  }
}
