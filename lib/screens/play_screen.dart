import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  static const String path = '/PlayScreen';
  const PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('woo')),
      body: Text('PlayScreen Screen'),
    );
  }
}
