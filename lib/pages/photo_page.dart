import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({Key key, this.photoURL}) : super(key: key);
  final String photoURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$photoURL"),
      ),
      body: Center(
        child: Image.network(
          photoURL,
        ),
      ),
    );
  }
}
