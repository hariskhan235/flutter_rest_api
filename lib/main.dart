import 'package:flutter/material.dart';
import 'package:rest_api_flutter/home_screen.dart';
import 'package:rest_api_flutter/sign_up.dart';
import 'package:rest_api_flutter/upload_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadImageScreen(),
    );
  }
}
