import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("page not found".tr),
      ),
    );
  }
}
