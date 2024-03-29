import 'dart:io';

import 'package:blindhelp/models/article_model.dart';
import 'package:blindhelp/models/chat_model.dart';
import 'package:blindhelp/models/check_home_user.dart';
import 'package:blindhelp/models/disease_model.dart';
import 'package:blindhelp/models/drug_label_model.dart';
import 'package:blindhelp/models/hitory_drug_model.dart';
import 'package:blindhelp/models/medicene_model.dart';
import 'package:blindhelp/models/name_th_model.dart';
import 'package:blindhelp/models/qr_model.dart';
import 'package:blindhelp/models/user_model.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxString typeUser = AppConstant.typeUsers[0].obs;
  RxList<NameThModel> provinceNameThModels = <NameThModel>[].obs;
  RxList<NameThModel?> chooseProviceModels = <NameThModel?>[null].obs;
  RxList<NameThModel> amphurNameThModels = <NameThModel>[].obs;
  RxList<NameThModel?> chooseAmphurModels = <NameThModel?>[null].obs;
  RxList<NameThModel> districeNameThModels = <NameThModel>[].obs;
  RxList<NameThModel?> chooseDistriceModels = <NameThModel?>[null].obs;
  RxBool accept = false.obs;
  RxBool remember = false.obs;
  RxBool load = true.obs;
  RxString uidLogin = ''.obs;
  RxList<UserModel> userModelLogins = <UserModel>[].obs;
  RxList<UserModel> userModelHelper = <UserModel>[].obs;
  RxList<String> lastMessages = <String>[].obs;
  RxInt indexBody = 0.obs;
  RxList<Timestamp> timestamps = <Timestamp>[].obs;
  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;
  RxList<DiseaseModel> userDiseaseModels = <DiseaseModel>[].obs;
  RxList<HistoryDrugModel> historyDrugModels = <HistoryDrugModel>[].obs;
  RxList<String> docIdDisease = <String>[].obs;
  RxList<String> docIdHistoryDrug = <String>[].obs;
  RxList<String> docIdMedicienes = <String>[].obs;
  RxList<MediceneModel> medicieneModels = <MediceneModel>[].obs;
  RxList<ChatModel> chatModels = <ChatModel>[].obs;
  RxList<DrugLabelModel> drugLabelModels = <DrugLabelModel>[].obs;
  RxList<String> docIdDrugLabels = <String>[].obs;
  RxList<CheckHomeUser> checkHomeUsers = <CheckHomeUser>[].obs;

  RxList<ArticleModel> articleModels = <ArticleModel>[].obs;
  RxList<String> docIdArticles = <String>[].obs;

  RxList<QrModel> qrModels = <QrModel>[].obs;
}
