import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class FullPage extends StatefulWidget {
  const FullPage({super.key});

  @override
  State<FullPage> createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  File? _imageFile;

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}