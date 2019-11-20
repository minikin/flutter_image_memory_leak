import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final int countImages = 1000;
  final int width = 320;
  final int height = 240;

  Future<List<Widget>> getlistOfRandomNetworkImages() async {
    return await loadImages();
  }

  List<Widget> loadImages() {
    List<Widget> randomImages = List();

    for(int i = 0; i < countImages; i++) {
      randomImages.add(
          Center(
              child: Image.network("https://loremflickr.com/$width/$height?random=$i")
          )
      );
    }

    return randomImages;
  }

  @override
  Widget build(BuildContext context) {

    final images = loadImages();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
            children: images,
      ),
    );
  }
}
