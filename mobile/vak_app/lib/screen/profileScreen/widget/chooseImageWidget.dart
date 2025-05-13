import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageWidget extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ChooseImageWidget({super.key, required this.onImageSelected});

  @override
  _ChooseImageWidgetState createState() => _ChooseImageWidgetState();
}

class _ChooseImageWidgetState extends State<ChooseImageWidget> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageContainerHeight = screenHeight * 0.3;

    return GestureDetector(
      onTap: _getImage,
      child: Container(
        height: imageContainerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _image!,
                  width: double.infinity,
                  height: imageContainerHeight,
                  fit: BoxFit.cover,
                ),
              )
            : const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_outlined, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text('Pilih Gambar', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
      ),
    );
  }
}

