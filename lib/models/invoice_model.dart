// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceModel {
  final String uid;
  final String downloadUrl;
  final String name;
  final Timestamp timestamp;

  InvoiceModel(
    this.uid,
    this.downloadUrl,
    this.name,
    this.timestamp,
  );

  InvoiceModel copyWith({
    String? uid,
    String? downloadUrl,
    String? name,
    Timestamp? timestamp,
  }) {
    return InvoiceModel(
      uid ?? this.uid,
      downloadUrl ?? this.downloadUrl,
      name ?? this.name,
      timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'downloadUrl': downloadUrl,
      'name': name,
      'timestamp': timestamp,
    };
  }

  factory InvoiceModel.fromMap(DocumentSnapshot map) {
    return InvoiceModel(
      map['uid'] as String,
      map['downloadUrl'] as String,
      map['name'] as String,
      map['addedon'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory InvoiceModel.fromJson(String source) => InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(uid: $uid, downloadUrl: $downloadUrl, name: $name, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.downloadUrl == downloadUrl &&
        other.name == name &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        downloadUrl.hashCode ^
        name.hashCode ^
        timestamp.hashCode;
  }
}
