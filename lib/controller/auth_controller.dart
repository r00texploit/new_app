import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_app_dashboard/screens/home.dart';
import 'package:registration_app_dashboard/screens/registrar_home.dart';
import 'package:registration_app_dashboard/screens/registrar_page.dart';
import 'package:registration_app_dashboard/screens/sign_in_page.dart';
import 'package:registration_app_dashboard/screens/welcome_page.dart';
import 'package:registration_app_dashboard/widgets/loading.dart';
import 'package:registration_app_dashboard/widgets/snackbar.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number;

  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onInit();
  }

  String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = LoginPage();
    } else {
      route = const HomeScreen();
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update();
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update();
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update();
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (password.text != value) {
      return "Password not matched ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('Are you are sure to log out'),
      actions: [
        TextButton(
            onPressed: () async {
              await auth
                  .signOut()
                  .then((value) => Get.offAll(() => const WelcomePage()));
            },
            child: const Text('yes')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('back'))
      ],
    ));
  }

  void register() async {
    if (formKey2.currentState!.validate()) {
      try {
        // SmartDialog.showLoading();
        showdilog();
        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': name.text,
          'email': email.text,
          'number': int.tryParse(number.text),
          'uid': credential.user!.uid,
        });
        Get.back();
        email.clear();
        password.clear();
        showbar("About User", "User message", "User Created!!", true);
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About User", "User message", e.toString(), false);
      }
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        var ch = await FirebaseFirestore.instance
            .collection('admin')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email.text)
            .get();
        var ch2 = await FirebaseFirestore.instance
            .collection('registrar')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email.text)
            .get();
        int approve = 0;
        for (var element in ch.docs) {
          if (element['email'] == email.text) {
            approve = 1;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        for (var element in ch2.docs) {
          if (element['email'] == email.text) {
            approve = 2;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        if (approve == 1) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => const HomeScreen());
        }
        if (approve == 2) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => const RegistrarHome());
        }
        if (approve == 0) {
          Get.back();
          showbar("About Login", "Login message", 'You dont have a permission',
              false);
        }
        // if (ch.docs.isNotEmpty) {
        //   Get.back();
        //   Get.offAll(() => const HomeScreen());
        // } else {

        // }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          showbar("About Login", "Login message", "weak password", false);
        }
        if (e.code == 'email-already-in-use') {
          Get.back();
          showbar(
              "About Login", "Login message", 'email-already-in-use', false);
        }
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message", ' user-not-found', false);
        }
        if (e.code == 'wrong-password') {
          Get.back();
          showbar("About Login", "Login message", ' wrong-password', false);
        } else {
          Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    }
  }
}
