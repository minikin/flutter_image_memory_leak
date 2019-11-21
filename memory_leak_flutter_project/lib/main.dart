import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

  final int countImages = 70;
  final int width = 320;
  final int height = 240;

  bool isLocal = true;

  List<Widget> loadNetworkImages() {
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

  List<Widget> loadLocalImages(List<FileSystemEntity> files) {
    return files.map((entity) => Center(child: Image.asset(entity.path))).toList();
  }

  Future<List<FileSystemEntity>> getLocalPathsToFile() async {
    final pathRootDirectory = await getApplicationDocumentsDirectory();
    final pathFolderTestImages = "${pathRootDirectory.path}/${width}x${height}";

    final directory = Directory(pathFolderTestImages);

    if(directory == null) {
      return [];
    }

    return directory.listSync();
  }

  @override
  Widget build(BuildContext context) {

    final images = !isLocal ? loadNetworkImages() : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLocal ? FutureBuilder<List<FileSystemEntity>>(
        future: getLocalPathsToFile(),
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView(children: loadLocalImages(snapshot.data)) : Center(child: CircularProgressIndicator());
        },
      ) : ListView(
            children: images,
      ),
    );
  }
}
