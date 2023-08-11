import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/modules/test_database_floor/home_database_floor_screen.dart';
import 'Signature/signature.dart';
import 'modal_bottomsheet.dart';
import 'test_database_sqlite/screens/home_database_screen.dart';
import 'widgets/btn.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Btn(
                  txtBtn: 'DB_SQLite',
                  onTap1: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeDatabaseScreen()),
                      )),
              const SizedBox(height: 30),
              Btn(
                  txtBtn: 'DB_Floor',
                  onTap1: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomeDatabaseFloorScreen()),
                      )),
              const SizedBox(height: 30),
              Btn(
                  txtBtn: 'ModalButtomSheet',
                  onTap1: () => ModalButtomSheet(context1: context).show()),
              const SizedBox(height: 30),
              Btn(
                  txtBtn: 'Click',
                  onTap1: () {
                    // await Pre().setPre();
                    print('object');
                  }),
              const SizedBox(height: 30),
              Btn(
                  txtBtn: 'Click2',
                  onTap1: () {
                    print('2');
                  }),
              Ink(
                color: Colors.amber,
                child: Text('Ink_Widget'),
              ),
              const AutoSizeText(
                'AutoSizeText_AutoSizeText_AutoSizeText_AutoSizeText',
                style: TextStyle(fontSize: 50),
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.amber,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignatureScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'SignatureScreen',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Pre {
//   Future<void> setPre() async {
//     final pr = await SharedPreferences.getInstance();
//     await pr.setString('key', 'asd');
//     print(' asd: ${await pr.setString('key', 'asd')}');
//   }
// }
