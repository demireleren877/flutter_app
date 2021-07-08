import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanText extends StatefulWidget {
  const ScanText({Key key}) : super(key: key);

  @override
  _ScanTextState createState() => _ScanTextState();
}

class _ScanTextState extends State<ScanText> {
  File pickedImage;
  bool isImageLoaded = false;
  final _picker = ImagePicker();
  Future pickImage() async {
    var tempstore = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempstore.path);
      isImageLoaded = true;
    });
  }

  Future scanText() async {
    FirebaseVisionImage ourimage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recogText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recogText.processImage(ourimage);
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Text"),
        actions: [
          IconButton(
              icon: Icon(Icons.scanner),
              color: Colors.white,
              onPressed: () {
                scanText();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            isImageLoaded
                ? Center(
                    child: Container(
                      height: 260,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(pickedImage), fit: BoxFit.cover),
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.fromLTRB(340, 460, 0, 0),
              height: 200,
              child: FloatingActionButton(
                onPressed: () {
                  pickImage();
                },
                backgroundColor: Colors.green,
                child: Icon(Icons.add_photo_alternate_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
