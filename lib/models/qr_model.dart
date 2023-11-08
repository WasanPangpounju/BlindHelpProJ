// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class QrModel {
  final String Hn;
  final String nameHospital;
  final String nameSurname;
  final String idHn;
  final String nameDrug;
  final String detailDrug;
  final String howtoDrug;
  final String properiesDrug;
  final String warnningDrug;
  final Timestamp expireDate;
  final String remark;
  QrModel({
    required this.Hn,
    required this.nameHospital,
    required this.nameSurname,
    required this.idHn,
    required this.nameDrug,
    required this.detailDrug,
    required this.howtoDrug,
    required this.properiesDrug,
    required this.warnningDrug,
    required this.expireDate,
    required this.remark,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Hn': Hn,
      'nameHospital': nameHospital,
      'nameSurname': nameSurname,
      'idHn': idHn,
      'nameDrug': nameDrug,
      'detailDrug': detailDrug,
      'howtoDrug': howtoDrug,
      'properiesDrug': properiesDrug,
      'warnningDrug': warnningDrug,
      'expireDate': expireDate,
      'remark': remark,
    };
  }

  factory QrModel.fromMap(Map<String, dynamic> map) {
    return QrModel(
      Hn: (map['Hn'] ?? '') as String,
      nameHospital: (map['nameHospital'] ?? '') as String,
      nameSurname: (map['nameSurname'] ?? '') as String,
      idHn: (map['idHn'] ?? '') as String,
      nameDrug: (map['nameDrug'] ?? '') as String,
      detailDrug: (map['detailDrug'] ?? '') as String,
      howtoDrug: (map['howtoDrug'] ?? '') as String,
      properiesDrug: (map['properiesDrug'] ?? '') as String,
      warnningDrug: (map['warnningDrug'] ?? '') as String,
      expireDate:(map['expireDate'] ?? Timestamp(0, 0)),
      remark: (map['remark'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrModel.fromJson(String source) => QrModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
