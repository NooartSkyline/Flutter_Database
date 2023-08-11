import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SignaturePreviewScreen extends StatelessWidget {
  final Uint8List? signature;
  final Function() onSavePng;
  const SignaturePreviewScreen(
      {super.key, required this.signature, required this.onSavePng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(signature!)),
        ),
      ),
      bottomSheet: Row(
        children: [
          CusButton(
            onTab: () {
              SaveSignature(context);
              onSavePng();
            },
            icon: Icons.save,
            txtButton: 'PNG',
          ),
          CusButton(
            onTab: () async {
              final imageEncoded = base64.encode(signature!);
              print('base64 : ${imageEncoded}');
              await Clipboard.setData(ClipboardData(text: imageEncoded));
            },
            icon: Icons.save,
            txtButton: 'Base64',
          ),
          CusButton(
            onTab: () {
              Navigator.pop(context);
            },
            icon: Icons.close,
            txtButton: 'Back',
          ),
        ],
      ),
    );
  }

  Future SaveSignature(BuildContext context) async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      await Permission.storage.request();
    }
    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'Signature ${time}';
    final result = await ImageGallerySaver.saveImage(signature!, name: name);
    final isSuccess = result['isSuccess'];

    if (isSuccess) {
      Navigator.pop(context);
    }
  }
}

Widget CusButton(
    {required Function onTab,
    required IconData icon,
    required String txtButton}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () => onTab(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                ),
                const SizedBox(width: 20),
                Text(
                  txtButton,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
