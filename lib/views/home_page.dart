import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR IF NEEDED,
      // DI MAIN PAGE GAUSAH DITAMBAHIN APP BAR (????)
      appBar: AppBar(
        title: const Text('Rumah singgah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'This is supposedly the Home Page',
            ),
          ],
        ),
      ),
    );
  }
}