import "package:flutter/material.dart";
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class QueryResultScreen extends StatefulWidget {
  const QueryResultScreen({Key? key}) : super(key: key);

  @override
  State<QueryResultScreen> createState() => _QueryResultScreenState();
}

class _QueryResultScreenState extends State<QueryResultScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              width: size.width * 1.2,
              child: TextField(
                controller: controller,
              ),
            ),
            Container(
              height: size.height * 0.04,
              child: ElevatedButton(
                  onPressed: () {
                    Provider.of<Controller>(context, listen: false)
                        .queryExecuteResult(controller.text);
                  },
                  child: Text("execute")),
            ),
            SizedBox(height: size.height * 0.04,),
            Container(
              height: size.height * 0.6,
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.queryResult.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.queryResult.toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
