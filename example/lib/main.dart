import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard_image/clipboard_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final imageUrl =
      'https://assets.hibot.us/images/dev-content-based/99737e91f8870bb9687e18e6d44fde9f52d2230a8559b93a02b03a0c2a3e3800@jpg';

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print('Oelo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onLongPress: () {
                  _copyImage(imageUrl);
                },
                child: CachedNetworkImage(imageUrl: imageUrl),
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Paste image'),
                onChanged: (value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyImage(String imageUrl) {
    DefaultCacheManager().getFileFromCache(imageUrl).then((fileInfo) {
      var path = fileInfo?.file?.path;
      if (path != null) {
        ClipboardImage.copyImage(path).then((value) {
          print(value);
        });
      }
    });
  }
}
