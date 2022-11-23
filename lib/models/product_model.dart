// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double cost;
  @HiveField(2)
  final int qty;

  ProductModel({
    required this.name,
    required this.cost,
    required this.qty,
  });

  ProductModel copyWith({
    String? name,
    double? cost,
    int? qty,
  }) {
    return ProductModel(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cost': cost,
      'qty': qty,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      cost: map['cost'] as double,
      qty: map['qty'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductModel(name: $name, cost: $cost, qty: $qty)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.cost == cost &&
      other.qty == qty;
  }

  @override
  int get hashCode => name.hashCode ^ cost.hashCode ^ qty.hashCode;
}
