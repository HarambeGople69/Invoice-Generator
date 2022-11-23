// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';

part 'company_model.g.dart';

@HiveType(typeId: 0)
class CompanyModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String address;

  CompanyModel(
    this.name,
    this.phone,
    this.email,
    this.url,
    this.address,
  );

  CompanyModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? url,
    String? address,
  }) {
    return CompanyModel(
      name ?? this.name,
      phone ?? this.phone,
      email ?? this.email,
      url ?? this.url,
      address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'url': url,
      'address': address,
    };
  }

  factory CompanyModel.fromMap(DocumentSnapshot map) {
    return CompanyModel(
      map['name'] as String,
      map['phone'] as String,
      map['email'] as String,
      map['url'] as String,
      map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanyModel(name: $name, phone: $phone, email: $email, url: $url, address: $address)';
  }

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phone == phone &&
      other.email == email &&
      other.url == url &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      url.hashCode ^
      address.hashCode;
  }
}
