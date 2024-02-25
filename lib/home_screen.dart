import 'package:flutter/material.dart';
import 'package:flutter_naver_map_sample/naver_map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NaverMapScreen()));
          },
          child: Text('Naver Map Open')),
    );
  }
}
