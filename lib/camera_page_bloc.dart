import 'package:camera/camera.dart';
import 'package:camera_pamlanjut/bloc/camerafile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPageBloc extends StatefulWidget {
  const CameraPageBloc({super.key});

  @override
  State<CameraPageBloc> createState() => _CameraPageBlocState();
}

class _CameraPageBlocState extends State<CameraPageBloc> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<CamerafileBloc>();
    if (bloc.state is! CameraReady) {
      bloc.add(InitializeCamera());
    }
  }

  IconData _flashIcon(FlashMode mode) {
    return switch (mode) {
      FlashMode.auto => Icons.flash_auto,
      FlashMode.always => Icons.flash_on,
      _ => Icons.flash_off,
    };
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return ClipOval(
      child: Material(
        color: Colors.white24,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(icon, color: Colors.white,),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}