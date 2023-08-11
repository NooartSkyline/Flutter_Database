import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  Function() onTap1;
  String txtBtn;
  Btn({required this.txtBtn, required this.onTap1, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap1();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.blueGrey),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            txtBtn,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
