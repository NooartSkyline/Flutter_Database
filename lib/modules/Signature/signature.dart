import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:test_flutter/modules/Signature/signature_preview_screen.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  late SignatureController clrt;

  @override
  void initState() {
    clrt = SignatureController(penStrokeWidth: 3, penColor: Colors.black);
    super.initState();
  }

  @override
  void dispose() {
    clrt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Signature(
        controller: clrt,
        backgroundColor: Colors.white,
      ),
      bottomSheet: Container(
        child: Row(
          children: [
            ButtonCus(
              icon: Icons.check,
              onTab: () async {
                if (clrt.isNotEmpty) {
                  final sign = await ExprotSignature();
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignaturePreviewScreen(
                            signature: sign,
                            onSavePng: () {
                              clrt.clear();
                            },
                          )));
                }
              },
              txtButton: 'Preview',
            ),
            const SizedBox(width: 10),
            ButtonCus(
              icon: Icons.restore,
              onTab: () {
                clrt.clear();
              },
              txtButton: 'Clear',
            ),
            const SizedBox(width: 10),
            ButtonCus(
              onTab: GetImage,
              icon: Icons.image,
              txtButton: 'Gallery',
            ),
            const SizedBox(width: 10),
            ButtonCus(
              icon: Icons.close,
              onTab: () {
                Navigator.pop(context);
              },
              txtButton: 'Back',
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> ExprotSignature() async {
    final exSignature = SignatureController(
        penStrokeWidth: 2,
        exportBackgroundColor: Colors.white,
        penColor: Colors.black,
        points: clrt.points);
    final signature = await exSignature.toPngBytes();
    exSignature.dispose();

    return signature;
  }
}

Widget ButtonCus(
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
          padding: const EdgeInsets.all(10),
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

Future<File> GetImage() async {
  final img = await ImagePicker().pickImage(source: ImageSource.gallery);

  final imgPath = File(img!.path);
  print(imgPath);
  return imgPath;
}
