import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Other'),
    ));
  }
}
