import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'camerafile_event.dart';
part 'camerafile_state.dart';

class CamerafileBloc extends Bloc<CamerafileEvent, CamerafileState> {
  late final List<CameraDescription> _cameras;
  
  CamerafileBloc() : super(CamerafileInitial()) {
    on<InitializeCamera>(_onInit);
    on<SwitchCamera>(_onSwitch);
    on<ToggleFlash>(_onToggleFlash);
    on<TakePicture>(_onTakePicture);
    on<TapToFocus>(_onTapToFocus);
    on<PickGallery>(_onPickGallery);
    on<OpenCameraAndCapture>(_onOpenCamera);
    on<DeleteImage>(_onDeleteImage);
    on<ClearSnackbar>(_onClearSnackbar);
    on<RequestPermissions>(_onRequestPermissions);
  }

  Future<void> _onInit(
    InitializeCamera event,
    Emitter<CamerafileState> emit,
  ) async {
    _cameras = await availableCameras();
    await _setupController(emit);
  }

  Future<void> _onSwitch(SwitchCamera event, Emitter<CamerafileState> emit) async {
    if (state is! CameraReady) return;
    final s = state as CameraReady;
    final next = (s.selectedIndex + 1) % _cameras.length;
    await _setupController(emit, next);
  }
}
