import 'package:flutter/material.dart';
import 'screens/counter_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'azfmzQd0nnTuxgt4MkTlrTo98C8NQV1GXb6slQrY';
  const clientKey = '2Cy3yytvSJQW8QUvhfbpkq8BJ6aOXkDixZYxivqb';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: clientKey,
    debug: true,
  );

  //var todoFlutter = ParseObject('TodoFlutter')..set('message', 'Hi I am Arya');
  //await todoFlutter.save();

  var todoFlutter = await ParseObject('TodoFlutter').getAll();

  if (todoFlutter.success) {
    for (var data in todoFlutter.result) {
      print(data.toString());
    }
  } else {
    print(todoFlutter.error);
  }
  runApp(MaterialApp(
    title: 'Counter App',
    home: CounterPage(),
  ));
}
