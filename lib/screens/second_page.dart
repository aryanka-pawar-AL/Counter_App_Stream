import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController messageEditingController = TextEditingController();
  final _scaffoldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _scaffoldKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: const Border(),
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: const [BoxShadow(color: Colors.blueAccent, blurRadius: 1.0, offset: Offset(0, 3))]),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Message",
                      ),
                      validator: (val) => (val == null || val.isEmpty) ? 'Enter a message' : null,
                      controller: messageEditingController,
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  add();
                },
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }

  final textInputDecoration = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
    hintStyle: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
  );

  void add() async {
    if (_scaffoldKey.currentState!.validate()) {
      var todoFlutter = ParseObject('TodoFlutter')..set('message', messageEditingController.text);
      await todoFlutter.save();
      Navigator.pop(context);
    }
  }
}
