import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hid_activity_macos/hid_activity_macos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _hidActivityMacosPlugin = HidActivityMacos();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: StreamBuilder<String>(
            stream: _hidActivityMacosPlugin.getActivityStream,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Text(snapshot.data!);
              } else {
                return const Text("Waiting for mouse activity...");
              }
            },
          ),
        ),
      ),
    );
  }
}
