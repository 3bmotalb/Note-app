import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

getalldata() async {
  FirebaseFirestore.instance.collection("users").get().then((value) => {
        value.docs.forEach((element) {
          print(element.data());
          print("---------------------");
        })
      });
}

getspec() async {
  var userref = FirebaseFirestore.instance.collection("users");
  await userref.where("age", whereIn: [23, 19]).get().then((value) => {
        value.docs.forEach((element) {
          print(element.data());
          print("-----------------");
        })
      });
}

getuser() async {
  FirebaseFirestore.instance
      .collection("users")
      .doc("oAJ6xZH5W2OhtzbkeaKO")
      .get()
      .then((value) => {print(value.data())});
}

File? file;
var imagepicker = ImagePicker();

uploadimage() async {
  var picked = await imagepicker.getImage(source: ImageSource.gallery);
  if (picked != null) {
    file = File(picked.path);
    var imagename = basename(picked.path);

    var random = Random().nextInt(1000000);
    imagename = '$random$imagename';

    // print('-----------------------------------------');
    // print("Image uploaded");
    // print('-----------------------------------------');
    print(imagename);
    var refstorage =
        FirebaseStorage.instance.ref().child('images').child(imagename);
    await refstorage.putFile(file!);
    var url = await refstorage.getDownloadURL();
    print("url : $url");
  } else {
    print("No Image uploaded");
  }
}

class _TestState extends State<Test> {
  getimage() async {
    var ref = await FirebaseStorage.instance.ref().list();
    ref.items.forEach((element) {
      print("-----------------------");
      print(element.name);
      print('hamed');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                uploadimage();
              },
              child: Text("upload"),
            ),
            RaisedButton(
              onPressed: () {
                getimage();
              },
              child: Text("upload"),
            )
          ],
        ),
      ),
    );
  }
}
