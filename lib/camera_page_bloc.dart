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
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CamerafileBloc, CamerafileState>(
        builder: (context, state) {
          if (
            state is! CameraReady
          ) {
            return const Center(child: CircularProgressIndicator());
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTapDown: (details) {
                      context.read<CamerafileBloc>().add(
                        TapToFocus(
                          details.localPosition, 
                          constraints.biggest
                        ),
                      );
                    },
                    child: CameraPreview(state.controller),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: Column(
                      children: [
                        _circleButton(Icons.flip_camera_android, () {
                          context.read<CamerafileBloc>().add(SwitchCamera());
                        }),
                        const SizedBox(height: 12),
                        _circleButton(_flashIcon(state.flashMode), () {
                          context.read<CamerafileBloc>().add(ToggleFlash());
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          context.read<CamerafileBloc>().add(
                            TakePicture(
                              (file) => Navigator.pop(context, file)
                            ),
                          );
                        },
                        child: 
                            const Icon(Icons.camera_alt, color: Colors.black),
                      ),
                    )
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}
