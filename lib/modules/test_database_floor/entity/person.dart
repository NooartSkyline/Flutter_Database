import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@entity
class Person_model {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'product_Name')
  @required
  final String productName;

  @required
  final String productPrice;

  Person_model({
    this.id,
    required this.productName,
    required this.productPrice,
  });
}
