import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('遷移先画面'),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}