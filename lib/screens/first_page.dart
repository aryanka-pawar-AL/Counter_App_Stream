import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:testing/screens/second_page.dart';

import '../models/message.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Parse Query Users"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Message>>(
            future: doUserQuery(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(width: 100, height: 100, child: CircularProgressIndicator()),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error...: ${snapshot.error.toString()}"),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('None user found'),
                      );
                    }

                    return ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];

                          return ListTile(
                            title: Text(data.message),
                            subtitle: Text(data.createdAt.toString()),
                          );
                        });
                  }
              }
            }));
  }

  Future<List<Message>> doUserQuery() async {
    QueryBuilder<ParseObject> queryUsers = QueryBuilder<ParseObject>(ParseObject("TodoFlutter"));
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      // return apiResponse.results as List<ParseObject>;

      List? data = (apiResponse.results);

      final messageList = <Message>[];

      for (var parseObject in (data!)) {
        Message message = Message.fromParse(parseObject);
        messageList.add(message);
      }
      print(messageList);
      return messageList;
    } else {
      return [];
    }
  }
}
