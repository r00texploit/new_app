import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_app_dashboard/widgets/loading.dart';
import 'dart:io';
import '../widgets/snackbar.dart';
import 'package:path/path.dart';

class AddTravelController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController name, dep, price, no, email, password;
  DateTime time = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  auth.User? user;

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    super.onInit();

    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    dep = TextEditingController();

    price = TextEditingController();
    no = TextEditingController();

    collectionReference = firebaseFirestore.collection("student");
    // realestates.bindStream(getAllRealEstate());
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Please Add All Field";
    }
    return null;
  }

  void clear() {
    dep.clear();
    no.clear();
    name.clear();
  }

  // final ImagePicker _picker = ImagePicker();
  // XFile? image;
  // void imageSelect() async {
  //   final XFile? selectedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (selectedImage!.path.isNotEmpty) {
  //     image = selectedImage;
  //     update(['image']);
  //   }
  // }

  // late String image_url;
  // Future uploadImageToFirebase() async {
  //   String fileName = basename(image!.path);

  //   var _imageFile = File(image!.path);

  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('mybus/$fileName');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

  //   await taskSnapshot.ref.getDownloadURL().then(
  //         (value) => image_url = value,
  //       );
  // }

  void addStudent() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      showdilog();
FirebaseAuth auth = FirebaseAuth.instance;
final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();
      var re = <String, dynamic>{
      'uid': credential.user!.uid,
        "No": int.tryParse(no.text),
        "department": dep.text,
        "name": name.text,
        "fees": 0,
        "status": false
      };
      collectionReference.doc().set(re).whenComplete(() {
        Get.back();
        showbar("Student Added", "Student Added", "Student Added ", true);
        clear();
      }).catchError((error) {
        Get.back();
        showbar("Error", "Error", error.toString(), false);
      });
    }
  }

  void addRegistrar() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      try {
        showdilog();
        FirebaseAuth auth = FirebaseAuth.instance;
        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();

        await FirebaseFirestore.instance
            .collection('registrar')
            .doc(credential.user!.uid)
            .set({
          'name': name.text,
          'email': email.text,
          'uid': credential.user!.uid,
        });
        Get.back();
        email.clear();
        password.clear();
        Get.back();
        showbar("Student Added", "Student Added", "Student Added ", true);
      } catch (e)
      // clear();
      {
        Get.back();
        showbar("Error", "Error", e.toString(), false);
      }
    }
  }
   void addDepartment() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      try {
        showdilog();
        await FirebaseFirestore.instance
            .collection('department')
            .doc()
            .set({
          'department': dep.text,
        });
        Get.back();
        dep.clear();
        Get.back();
        showbar("department Added", "Student Added", "department Added ", true);
      } catch (e)
      // clear();
      {
        Get.back();
        showbar("Error", "Error", e.toString(), false);
      }
    }
  }
}
