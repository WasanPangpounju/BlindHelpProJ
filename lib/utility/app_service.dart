// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:blindhelp/utility/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> addChat(
      {required Map<String, dynamic> map, String? docIdUser}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docIdUser ?? appController.userModelLogins.last.uid)
        .collection('chat')
        .doc()
        .set(map);
  }

  Future<void> editDisease(
      {required String docIdDisease, required Map<String, dynamic> map}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('disease')
        .doc(docIdDisease)
        .update(map);
  }

  Future<void> editHistoryDrug(
      {required String docIdHistoryDrug,
      required Map<String, dynamic> map}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('historyDrug')
        .doc(docIdHistoryDrug)
        .update(map);
  }

  Future<void> deleteDisease({required String docIdDisease}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('disease')
        .doc(docIdDisease)
        .delete();
  }

  Future<void> deleteHistoryDrug({required String docIdHIstoryDrug}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('historyDrug')
        .doc(docIdHIstoryDrug)
        .delete();
  }

  Future<void> deleteMediciene({required String docIdMediciene}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('mediciene')
        .doc(docIdMediciene)
        .delete();
  }

  Future<void> editUserProfile({required Map<String, dynamic> map}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .update(map);
  }

  Future<void> readDisease({String? docIdUserOwnerDisease}) async {
    String docIdUser =
        docIdUserOwnerDisease ?? appController.userModelLogins.last.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docIdUser)
        .collection('disease')
        .orderBy('timestamp')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (appController.userDiseaseModels.isNotEmpty) {
          appController.userDiseaseModels.clear();
          appController.docIdDisease.clear();
        }

        for (var element in value.docs) {
          DiseaseModel diseaseModel = DiseaseModel.fromMap(element.data());
          appController.userDiseaseModels.add(diseaseModel);
          appController.docIdDisease.add(element.id);
        }
      }
    });
  }

  Future<void> readHistoryDrug({String? docIdUserHistoryDrug}) async {
    String docIdUser =
        docIdUserHistoryDrug ?? appController.userModelLogins.last.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docIdUser)
        .collection('historyDrug')
        .orderBy('timestamp')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (appController.historyDrugModels.isNotEmpty) {
          appController.historyDrugModels.clear();
          appController.docIdHistoryDrug.clear();
        }

        for (var element in value.docs) {
          HistoryDrugModel historyDrugModel =
              HistoryDrugModel.fromMap(element.data());
          appController.historyDrugModels.add(historyDrugModel);
          appController.docIdHistoryDrug.add(element.id);
        }
      }
    });
  }

  Future<void> addDisease({required DiseaseModel diseaseModel}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('disease')
        .doc()
        .set(diseaseModel.toMap());
  }

  Future<void> addHistoryDrug(
      {required HistoryDrugModel historyDrugModel}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('historyDrug')
        .doc()
        .set(historyDrugModel.toMap());
  }

  Future<String?> uploadImage({required String path}) async {
    String? urlImage;
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child('$path/${appController.nameFiles.last}');

    UploadTask uploadTask = reference.putFile(appController.files.last);
    await uploadTask.whenComplete(() async {
      urlImage = await reference.getDownloadURL();
    });

    return urlImage;
  }

  Future<void> takePhoto({required ImageSource imageSource}) async {
    if (appController.files.isNotEmpty) {
      appController.files.clear();
      appController.nameFiles.clear();
    }

    var result = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      String string = basename(result.path);
      var strings = string.split('.');

      appController.files.add(File(result.path));
      appController.nameFiles.add('${strings.first}.jpg');
    }
  }

  String timeStampToString({required Timestamp timestamp}) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String string = dateFormat.format(timestamp.toDate());
    return string;
  }

  Future<void> readUserModelLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      UserModel userModel = UserModel.fromMap(value.data()!);
      appController.userModelLogins.add(userModel);
    });
  }

  Future<void> updateUser({required Map<String, dynamic> data}) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid);

    documentReference.update(data);
  }

  Future<void> readDistrice({required String idAmphur}) async {
    if (appController.districeNameThModels.isNotEmpty) {
      appController.districeNameThModels.clear();
      appController.chooseDistriceModels.clear();
      appController.chooseDistriceModels.add(null);
    }

    String urlApi =
        'https://www.androidthai.in.th/flutter/getDistriceByAmphure.php?isAdd=true&amphure_id=$idAmphur';
    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        NameThModel model = NameThModel.fromMap(element);
        appController.districeNameThModels.add(model);
      }
    });
  }

  Future<void> readAmphur({required String idProvince}) async {
    if (appController.amphurNameThModels.isNotEmpty) {
      appController.amphurNameThModels.clear();
      appController.chooseAmphurModels.clear();
      appController.chooseAmphurModels.add(null);
    }

    String urlApi =
        'https://www.androidthai.in.th/flutter/getAmpByProvince.php?isAdd=true&province_id=$idProvince';
    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        NameThModel model = NameThModel.fromMap(element);
        appController.amphurNameThModels.add(model);
      }
    });
  }

  Future<void> readProvince() async {
    String urlApi = 'https://www.androidthai.in.th/flutter/getAllprovinces.php';
    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        NameThModel provicneNameThModel = NameThModel.fromMap(element);
        appController.provinceNameThModels.add(provicneNameThModel);
      }
    });
  }

  Future<void> processAddMedicene(
      {required String nameMedicene, required String amountMedicene}) async {
    MediceneModel mediceneModel = MediceneModel(
        nameMedicene: nameMedicene,
        amountMedicene: amountMedicene,
        timestamp: Timestamp.fromDate(DateTime.now()));

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('mediciene')
        .doc()
        .set(mediceneModel.toMap());
  }

  Future<void> readAllMediciene() async {
    if (appController.medicieneModels.isNotEmpty) {
      appController.medicieneModels.clear();
    }

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('mediciene')
        .orderBy('timestamp')
        .get()
        .then((value) {
      if (appController.medicieneModels.isNotEmpty) {
        appController.medicieneModels.clear();
        appController.docIdMedicienes.clear();
      }

      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          MediceneModel mediceneModel = MediceneModel.fromMap(element.data());
          appController.medicieneModels.add(mediceneModel);
          appController.docIdMedicienes.add(element.id);
        }
      }
    });
  }

  Future<void> readDrugLableByUid() async {
    if (appController.drugLabelModels.isNotEmpty) {
      appController.drugLabelModels.clear();
      appController.docIdDrugLabels.clear();
    }

    await FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('druglabel')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          DrugLabelModel drugLabelModel =
              DrugLabelModel.fromMap(element.data());
          appController.drugLabelModels.add(drugLabelModel);
          appController.docIdDrugLabels.add(element.id);
        }
      }
    });
  }

  Future<void> readAllDrugLabel() async {
    if (appController.drugLabelModels.isNotEmpty) {
      appController.drugLabelModels.clear();
      appController.docIdDrugLabels.clear();
    }

    FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(element.id)
            .collection('druglabel')
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            for (var element in value.docs) {
              DrugLabelModel drugLabelModel =
                  DrugLabelModel.fromMap(element.data());
              appController.drugLabelModels.add(drugLabelModel);
              appController.docIdDrugLabels.add(element.id);
            }
          }
        });
      }
    });
  }

  Future<void> editDrugLabel(
      {required Map<String, dynamic> map,
      required String docIdUser,
      required String docIdDrugLabel}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(docIdUser)
        .collection('druglabel')
        .doc(docIdDrugLabel)
        .update(map);
  }

  Future<void> readUser() async {
    FirebaseFirestore.instance
        .collection('user')
        .where('typeUser', isEqualTo: AppConstant.typeUsers[0])
        .get()
        .then((value) {
      if (appController.userModelHelper.isNotEmpty) {
        appController.userModelHelper.clear();
        appController.lastMessages.clear();
      }

      for (var element in value.docs) {
        UserModel userModel = UserModel.fromMap(element.data());
        appController.userModelHelper.add(userModel);

        FirebaseFirestore.instance
            .collection('user')
            .doc(element.id)
            .collection('chat')
            .orderBy('timestamp')
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            ChatModel? chatModel;
            for (var element in value.docs) {
              chatModel = ChatModel.fromMap(element.data());
            }
            appController.lastMessages.add(chatModel?.message ?? '');
          } else {
            appController.lastMessages.add('');
          }
        });
      }
    });
  }

  Future<void> readCheckHome() async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('checkhome')
        .orderBy('recordTimestamp')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (appController.checkHomeUsers.isNotEmpty) {
          appController.checkHomeUsers.clear();
        }

        for (var element in value.docs) {
          CheckHomeUser checkHomeUser = CheckHomeUser.fromMap(element.data());
          appController.checkHomeUsers.add(checkHomeUser);
        }
      }
    });
  }

  Future<void> deleteDrugLabel({required String docIdDrugLabel}) async {
    print('docIdDrugLabel ---> $docIdDrugLabel');

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('druglabel')
        .doc(docIdDrugLabel)
        .delete()
        .then((value) {
      print('deleta success');
    });
  }

  Future<void> processEditArticle(
      {required Map<String, dynamic> map, required String docIdArticle}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('article')
        .doc(docIdArticle)
        .update(map);
  }

  Future<void> addNewArticle({
    required String article,
    required String title,
  }) async {
    String? urlImage;

    if (appController.files.isNotEmpty) {
      urlImage = await uploadImage(path: 'article');
    }

    ArticleModel articleModel = ArticleModel(
        article: article,
        timestamp: Timestamp.fromDate(DateTime.now()),
        title: title,
        urlImage: urlImage ?? '');
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('article')
        .doc()
        .set(articleModel.toMap());
  }

  Future<void> readMyArticle() async {
    if (appController.articleModels.isNotEmpty) {
      appController.articleModels.clear();
      appController.docIdArticles.clear();
    }

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('article')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          ArticleModel articleModel = ArticleModel.fromMap(element.data());
          appController.articleModels.add(articleModel);
          appController.docIdArticles.add(element.id);
        }
      }
    });
  }

  Future<void> readAllArticle() async {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      if (appController.articleModels.isNotEmpty) {
        appController.articleModels.clear();
      }

      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(element.id)
            .collection('article')
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            for (var element in value.docs) {
              ArticleModel articleModel = ArticleModel.fromMap(element.data());
              appController.articleModels.add(articleModel);
            }
          }
        });
      }
    });
  }

  Future<void> getQrData() async {
   

    for (var i = 0; i < 5; i++) {
       int iRandom = Random().nextInt(1000);
      QrModel qrModel = QrModel(
          nameHospital: 'nameHospital$iRandom',
          nameSurname: 'nameSurname$iRandom',
          idHn: 'idHn$iRandom',
          nameDrug: 'nameDrug$iRandom',
          detailDrug: 'detailDrug$iRandom',
          howtoDrug: 'howtoDrug$iRandom',
          properiesDrug: 'properiesDrug$iRandom',
          warnningDrug: 'warnningDrug$iRandom',
          expireDate: Timestamp.fromDate(DateTime.now()),
          remark: 'remark$iRandom', Hn: '');

      FirebaseFirestore.instance
          .collection('qrdata')
          .doc()
          .set(qrModel.toMap());
    }
  }

  Future<void> readQrFromResult({required String resultQr}) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('qrdata')
          .where('idHn', isEqualTo: resultQr)
          .get();

      if (appController.qrModels.isNotEmpty) {
        appController.qrModels.clear();
      }

      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          QrModel qrModel = QrModel.fromMap(element.data());
          appController.qrModels.add(qrModel);
        }
      }
    } finally {
      appController.load.value = false;
    }
  }
}
