import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration_app_dashboard/controller/add_travel_controller.dart';
import 'package:registration_app_dashboard/widgets/custom_textfield.dart';

class AddDepartment extends StatelessWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Department'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
    ;
  }
}

Widget form(context) {
  TextEditingController n = TextEditingController();
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<AddTravelController>(
      init: AddTravelController(),
      builder: (_) {
        return Form(
          key: _.formKey,
          child: Container(
              // height: height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(46),
                  topRight: Radius.circular(46),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _.dep,
                        validator: (value) {
                          return _.validateAddress(value!);
                        },
                        lable: 'department',
                        icon: const Icon(Icons.numbers),
                        input: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      // const SizedBox(height: 20),
                      // CustomTextField(
                      //     controller: logic.price,
                      //     validator: (value) {
                      //       return logic.validateAddress(value!);
                      //     },
                      //     lable: 'السعر',
                      //     icon: const Icon(Icons.attach_money),
                      //     input: TextInputType.number),
                      // const SizedBox(height: 20),
                      // CustomTextField(
                      //     controller: logic.no,
                      //     validator: (value) {
                      //       return logic.validateAddress(value!);
                      //     },
                      //     lable: 'عدد المقاعد',
                      //     icon: const Icon(Icons.numbers),
                      //     input: TextInputType.number),
                      // // const SizedBox(height: 20),

                      // TextButton(
                      //   onPressed: () {
                      //     logic.getDatetime(context);
                      //   },
                      //   child: const Text(' تعديل التوقيت '),
                      //   style: ButtonStyle(
                      //     padding: MaterialStateProperty.all(EdgeInsets.only(
                      //         top: height / 65,
                      //         bottom: height / 65,
                      //         left: width / 10,
                      //         right: width / 10)),
                      //     backgroundColor: MaterialStateProperty.all(
                      //         const Color.fromRGBO(19, 26, 44, 1.0)),
                      //     shape:
                      //         MaterialStateProperty.all<RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(13),
                      //                 side: const BorderSide())),
                      //   ),
                      // ),
                      // CustomTextField(controller: logic.count, validator: (value){
                      //   return logic.validateAddress(value!);
                      // }, lable: 'زمن الرحلة'),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () async {
                              _.addDepartment();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(
                                      top: height / 55,
                                      bottom: height / 55,
                                      left: width / 10,
                                      right: width / 10)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(19, 26, 44, 1.0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(
                                              19, 26, 44, 1.0)))),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 16),
                            )),
                      )
                    ],
                  ),
                ],
              )),
        );
      });
}
