// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String typeUser;
  final String name;
  final String surName;
  final String phone;
  final String email;
  final String password;
  final String province;
  final String amphur;
  final String districe;
  final String zipCode;
  final String alleyWay;
  final String houseNumber;
  final String spcial;
  final Timestamp timestamp;
  final String? bloodTyoe;
  final String? gender;
  final String? age;
  final Timestamp? birth;
  final String? weight;
  final String? height;
  final String? urlAvatar;
  final String? disibility;
  final bool? activeAccount;
  UserModel({
    required this.uid,
    required this.typeUser,
    required this.name,
    required this.surName,
    required this.phone,
    required this.email,
    required this.password,
    required this.province,
    required this.amphur,
    required this.districe,
    required this.zipCode,
    required this.alleyWay,
    required this.houseNumber,
    required this.spcial,
    required this.timestamp,
    this.bloodTyoe,
    this.gender,
    this.age,
    this.birth,
    this.weight,
    this.height,
    this.urlAvatar,
    this.disibility,
    this.activeAccount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'typeUser': typeUser,
      'name': name,
      'surName': surName,
      'phone': phone,
      'email': email,
      'password': password,
      'province': province,
      'amphur': amphur,
      'districe': districe,
      'zipCode': zipCode,
      'alleyWay': alleyWay,
      'houseNumber': houseNumber,
      'spcial': spcial,
      'timestamp': timestamp,
      'bloodTyoe': bloodTyoe,
      'gender': gender,
      'age': age,
      'birth': birth,
      'weight': weight,
      'height': height,
      'urlAvatar': urlAvatar,
      'disibility': disibility,
      'activeAccount': activeAccount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
     uid: (map['uid'] ?? '') as String,
      typeUser: (map['typeUser'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      surName: (map['surName'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      province: (map['province'] ?? '') as String,
      amphur: (map['amphur'] ?? '') as String,
      districe: (map['districe'] ?? '') as String,
      zipCode: (map['zipCode'] ?? '') as String,
      alleyWay: (map['alleyWay'] ?? '') as String,
      houseNumber: (map['houseNumber'] ?? '') as String,
      spcial: (map['spcial'] ?? '') as String,
      timestamp: map['timestamp'],
      bloodTyoe: (map['bloodTyoe'] ?? '') as String,
      gender: (map['gender'] ?? '') as String,
      age: (map['age'] ?? '') as String,
      birth: map['birth'] ?? Timestamp(0, 0),
      weight: (map['weight'] ?? '') as String,
      height: (map['height'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? '') as String,
      disibility: (map['disibility'] ?? '') as String,
      activeAccount: (map['activeAccount'] ?? true) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
