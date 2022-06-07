import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_app_dashboard/controller/auth_controller.dart';
import 'package:registration_app_dashboard/screens/home.dart';
import 'package:registration_app_dashboard/widgets/custom_button.dart';
import 'package:registration_app_dashboard/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: GetBuilder<AuthController>(
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                    key: _.formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Login",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Welcome back ! Login with your credentials",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _.email,
                                  validator: (value) {
                                    return _.validate(value!);
                                  },
                                  lable: 'Email',
                                  icon: const Icon(Icons.email),
                                  input: TextInputType.emailAddress),
                              CustomTextField(
                                  controller: _.password,
                                  validator: (value) {
                                    return _.validatePassword(value!);
                                  },
                                  lable: 'Password',
                                  icon: const Icon(Icons.lock),
                                  input: TextInputType.text),
                            ],
                          ),
                        ),
                        CustomTextButton(
                            lable: 'Login',
                            ontap: () {
                              _.login();
                            },
                            color: Colors.blueAccent)
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Dont have an account?"),
                        //     Text(
                        //       "Sign Up",
                        //       style:4
                        //           Te                         رxtStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
