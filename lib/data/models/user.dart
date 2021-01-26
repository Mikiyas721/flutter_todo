import 'package:flutter/material.dart';
import '../../util/abstracts/mappable.dart';

class User extends Mappable {
  int id;
  String fullName;
  String userName;
  String email;
  String passWord;
  DateTime createdAt;

  User({
    this.id,
    this.fullName,
    @required this.userName,
    this.email,
    @required this.passWord,
    this.createdAt,
  });

  @override
  Map toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'passWord': passWord,
      'createdAt': createdAt.toString(),
    };
  }
}
