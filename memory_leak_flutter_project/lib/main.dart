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
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int countImages = 1000;
  final int width = 4096;
  final int height = 3072;
  List<String> _imageUrlList = [];

  @override
  void initState() {
    setState(() => _imageUrlList = _buildImageUrlList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: _imageUrlList.length,
              itemBuilder: (_, index) {
                return PhotoItem(
                  imageUrl: _imageUrlList[index],
                );
              }),
        ),
      ),
    );
  }

  List<String> _buildImageUrlList() {
    List<String> _imageUrlList = [];
    for (var i = 0; i < countImages; i++) {
      _imageUrlList.add('https://loremflickr.com/$width/$height?random=$i');
    }
    return _imageUrlList;
  }
}

class PhotoItem extends StatelessWidget {
  final String imageUrl;
  const PhotoItem({
    @required this.imageUrl,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin: const EdgeInsets.all(4),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
