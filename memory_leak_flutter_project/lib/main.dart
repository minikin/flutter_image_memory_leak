import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<String> _items = List<String>.generate(
      10000, (i) => 'https://loremflickr.com/4096/3072?random=$i');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                return PhotoItem(
                  imageUrl: _items[index],
                );
              },
            ),
          ),
        ),
      ),
    );
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
