import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< Updated upstream
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);
=======

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});
>>>>>>> Stashed changes

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
<<<<<<< Updated upstream
  late File _imageFile = File('');

  Future<void> _captureImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    final File newImage = File(image.path);
    setState(() {
      _imageFile = newImage;
    });

    // You can save the image to the temporary directory
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String fileName = 'captured_image.jpg'; // You can generate a unique file name if necessary
    final File tempImage = await newImage.copy('$tempPath/$fileName');
    // Now, the image is stored in the temporary directory
  }
}

=======
  File? _imageFile;

  Future<void> _captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
<<<<<<< Updated upstream
            _imageFile == null || _imageFile.path.isEmpty // Check if _imageFile is null or its path is empty
                ? const Text('No image captured')
                : Image.memory(_imageFile.readAsBytesSync()), // Use Image.memory to display the image
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _captureImage(ImageSource.gallery);
              },
              child: const Text('Select from Gallery'),
=======
            _imageFile == null
                ? const Text('No image captured')
                : Image.file(_imageFile!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _captureImage();
              },
              child: const Text('Open Camera'),
>>>>>>> Stashed changes
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CameraPage(),
  ));
}
