import 'package:flutter/material.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// ignore_for_file: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class ImageProcessingScreen extends StatefulWidget {
  const ImageProcessingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageProcessingScreenState createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  File? _selectedImage;
  File? _processedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processamento de Imagem'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _selectedImage != null
                ? Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                          image: FileImage(_selectedImage!),
                        )),
                  )
                : const Icon(Icons.image_not_supported_sharp),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.photo_camera),
                onPressed: () {
                  _getImageFromCamera();
                },
                label: const Text('Tirar Foto'),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image_search_sharp),
                onPressed: () {
                  _getImageFromGallery();
                },
                label: const Text('Galeria'),
              ),
              TextButton.icon(
                icon: const Icon(Icons.translate_sharp),
                onPressed: () {
                  _processImage();
                },
                label: const Text('Traduzir'),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          _processedImage != null ? Image.file(_processedImage!) : Container(),
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  Future<void> _processImage() async {
    if (_selectedImage == null) {
      return;
    }

    try {
      final imagePath = _selectedImage!.path;

      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/processed_image.jpg';

      //Tons de cinza
      //grade
      //outras operações
      final processedImageBytes = await Cv2.cvtColor(
        pathFrom: CVPathFrom.GALLERY_CAMERA,
        pathString: imagePath,
        outputType: Cv2.COLOR_BGR2GRAY,
      );

      if (processedImageBytes != null) {
        await File(tempFilePath).writeAsBytes(processedImageBytes);
        setState(() {
          _selectedImage = File(tempFilePath);
        });
      }
    } catch (e) {
      print('Erro ao processar a imagem: $e');
    }
  }
}
