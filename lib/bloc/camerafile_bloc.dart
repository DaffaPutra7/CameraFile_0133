import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'camerafile_event.dart';
part 'camerafile_state.dart';

class CamerafileBloc extends Bloc<CamerafileEvent, CamerafileState> {
  CamerafileBloc() : super(CamerafileInitial()) {
    on<CamerafileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
