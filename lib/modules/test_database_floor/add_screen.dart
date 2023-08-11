import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'entity/person.dart';

enum TypeBtn { btnDefault, btnGanItem, btnGanList }

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late TextEditingController clTxtProductName, clTxtProductPrice, clTxtLength;

  final faker = Faker();
  late List<Person_model> listPer = [];

  @override
  void initState() {
    clTxtProductName = TextEditingController();
    clTxtProductPrice = TextEditingController();
    clTxtLength = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    clTxtProductName.dispose();
    clTxtProductPrice.dispose();
    clTxtLength.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Container(),
        backgroundColor: Colors.amber,
        title: const Text(
          'เพิ่มรายการ',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          // SizedBox(
          //   height: 40,
          // ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              // focusNode: isFocusProductName,
              controller: clTxtProductName,
              // obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อสินค้า',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              // focusNode: isFocusProductPrice,
              controller: clTxtProductPrice,
              // obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ราคาสินค้า',
              ),
            ),
          ),
          btnAdd(
            txtBtn: 'เพิ่ม',
            onGet: () {
              if (clTxtProductName.text == '' || clTxtProductPrice.text == '') {
                if (clTxtProductName.text == '') {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                        const SnackBar(content: Text('กรุณาใส่ชื่อสินค้า!')));
                } else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                        const SnackBar(content: Text('กรุณาใส่ราคาสินค้า!')));
                }
              } else {
                Navigator.pop(
                    context,
                    Person_model(
                      productName: clTxtProductName.text,
                      productPrice: clTxtProductPrice.text,
                    ));
              }
            },
          ),
          const SizedBox(height: 30),
          btnAdd(
            txtBtn: 'Generage Item',
            onGet: () {
              Navigator.pop(
                  context,
                  Person_model(
                      productName: faker.person.name(),
                      productPrice: faker.person.lastName()));
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              maxLength: 4,
              // focusNode: isFocusProductPrice,
              controller: clTxtLength,
              // obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'จำนวนรายการที่จะเพิ่ม',
              ),
            ),
          ),
          btnAdd(
            txtBtn: 'Generage List',
            onGet: () {
              Navigator.pop(
                  context,
                  List.generate(
                      clTxtLength.text == '' ? 1 : int.parse(clTxtLength.text),
                      (index) => Person_model(
                          productName: faker.person.name(),
                          productPrice: faker.person.lastName())));
            },
          )
        ],
      )),
    );
  }
}

class btnAdd extends StatelessWidget {
  Function() onGet;

  String txtBtn;

  btnAdd({
    required this.txtBtn,
    required this.onGet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onGet();
      },
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          txtBtn,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
