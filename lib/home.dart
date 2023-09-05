import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  Uint8List? _byte;

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image != null ? File(image.path) : null;
    });
  }

  Future takePicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image != null ? File(image.path) : null;
    });
  }

  Future applyFilter() async {
    var res = await Cv2.cvtColor(
      pathFrom: CVPathFrom.GALLERY_CAMERA,
      pathString: _image!.path,
      outputType: Cv2.COLOR_BGR2GRAY,
    );

    setState(() {
      _byte;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MuiraKitã Braille"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            width: double.maxFinite,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: getImageFromGallery,
                  icon: const Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
              child: Container(
                  color: Colors.red,
                  child: _image != null
                      ? Center(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(
                                image: FileImage(_image!),
                              )),
                        )
                      : null)),
          // Expanded(
          //   child: Container(
          //     color: Colors.red,
          //     child: _image != null
          //         ? Center(
          //             child: Padding(
          //                 padding: const EdgeInsets.all(10.0),
          //                 child: Image(image: FileImage(_image!)
          //           )
          //         : null,
          //   ),
          // ),),

          Expanded(
            child: Container(
              color: Colors.blue,
              width: double.maxFinite,
              height: 100,
              child: ListView(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
