import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageButton extends StatelessWidget {
  final Function(String imagePath) onImageSelected;

  const AddImageButton({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: const Color(0xFF5F33E1),
      strokeWidth: 1.5,
      dashPattern: const [2, 2],
      radius: const Radius.circular(12),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () => _showImageSourceDialog(context),
          icon: const Icon(
            Icons.add_photo_alternate_outlined,
            color: Color(0xFF5F33E1),
            size: 24,
          ),
          label: const Text('Add Img',
              style: TextStyle(color: Color(0xFF5F33E1), fontSize: 16)),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            foregroundColor: const Color(0xFF5F33E1),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF5F33E1)),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library, color: Color(0xFF5F33E1)),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      onImageSelected(pickedImage.path);
      print(pickedImage);
    }
  }
}
