import 'package:camera_pamlanjut/bloc/camerafile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends StatelessWidget {
  const HomePageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: SafeArea(
        child: BlocConsumer<CamerafileBloc, CamerafileState>(
          listener: (context, state) {
            if (state is CameraReady && state.snackbarMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.snackbarMessage!)));
              context.read<CamerafileBloc>().add(ClearSnackbar());
            }
          },
          builder: (context, state) {
            // final File? imageFile =
            //     state is CameraReady ? state.imageFile : null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.camera),
                        onPressed: () {
                          final bloc = context.read<CamerafileBloc>();
                          if (bloc.state is! CameraReady) {
                            bloc.add(InitializeCamera());
                          }
                          bloc.add(OpenCameraAndCapture(context));
                        },
                        label: const Text('Ambil Foto'),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.folder),
                      onPressed:
                          () => context.read<CamerafileBloc>().add(
                            PickImageFromGallery(),
                          ),
                      label: const Text('Pilih dari Galeri'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<CamerafileBloc, CamerafileState>(
                  builder: (context, state) {
                    final imageFile =
                        state is CameraReady ? state.imageFile : null;

                    return imageFile != null
                        ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                imageFile,
                                width: double.infinity,
                              ),
                            ),
                            Text('Gambar disimpan di: ${imageFile.path}'),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.delete),
                              onPressed: () => context
                                  .read<CamerafileBloc>()
                                  .add(DeleteImage()), 
                              label: const Text('Hapus Gambar'),
                            )
                          ],
                        )
                      : const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Belum ada gambar diambil/dipilih.'), 
                      );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
