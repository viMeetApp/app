import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {

   static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreatePostPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Neuen Post erstellen"),),
      
    );
  }
}