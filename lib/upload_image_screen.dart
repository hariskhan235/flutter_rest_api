import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    try {
      var stream = http.ByteStream(
        image!.openRead(),
      );
      var lenght = await image!.length();
      var uri = Uri.parse('endpoint url');

      var request = http.MultipartRequest('POST', uri);
      request.fields['title'] = "Static title";

      var multiPart = http.MultipartFile('image', stream, lenght);

      request.files.add(multiPart);

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image Uploaded sucessfully');
        setState(() {
          showSpinner = false;
        });
      } else {
        print('Failed');
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null
                    ? const Center(
                        child: Text('Pick Image'),
                      )
                    : Container(
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height:150),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height:50,
                color: Colors.green,
                child: Text('Uplaod'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
