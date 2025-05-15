import 'dart:io';

import 'package:camera_pamlanjut/camera_page.dart';
import 'package:camera_pamlanjut/storage_helper.dart';
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

  Future<void> _takePicture() async {
    await _requestPermissions();
    final File? result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );
    if (result != null) {
      final saved = await StorageHelper.saveImage(result, 'camera');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Disimpan: ${saved.path}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}