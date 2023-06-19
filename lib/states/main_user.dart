import 'package:blindhelp/bodys/emergency_user.dart';
import 'package:blindhelp/bodys/help_user.dart';
import 'package:blindhelp/bodys/home_user.dart';
import 'package:blindhelp/bodys/read_drug_lable.dart';
import 'package:blindhelp/states/disease_list.dart';
import 'package:blindhelp/states/edit_profile_user.dart';
import 'package:blindhelp/states/historu_drug_list.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/widgets/widget_header_drawer.dart';
import 'package:blindhelp/widgets/widget_menu.dart';
import 'package:blindhelp/widgets/widget_signout.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainUser extends StatefulWidget {
  const MainUser({super.key});

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  var titles = <String>[
    'หน้าแรก',
    'โทรฉุกเฉิน',
    'อ่านฉลากยา',
    'ช่วยเหลือ',
  ];

  var appBarTitles = <String>[
    'ข้อมูลสุขภาพ',
    'ติดต่อโรงพยาบาล',
    'อ่านฉลากยา',
    'ความช่วยเหลือ',
  ];

  var bodys = <Widget>[
    const HomeUser(),
    const EmergencyUser(),
    const ReadDrugLabel(),
    const HelpUser(),
  ];

  var icons = <IconData>[
    Icons.home,
    Icons.phone,
    Icons.menu_book,
    Icons.live_help,
  ];

  var items = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();

    AppService().readUserModelLogin();

    AppService().readDisease();

    AppService().readHistoryDrug();

    for (var i = 0; i < titles.length; i++) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(icons[i]),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          return Scaffold(
            appBar: AppBar(
              title:
                  WidgetText(data: appBarTitles[appController.indexBody.value]),
              // actions: const [WidgetSignOut()],
            ),
            endDrawer: Drawer(
              child: Column(
                children: [
                  const WidgetHeaderDrawer(),
                  WidgetMemu(
                    leadWidget: const Icon(Icons.person),
                    titleWidget: const WidgetText(data: 'แก้ไขข้อมูล'),
                    tapFunc: () {
                      Get.back();
                      Get.to(const EditProfileUser())!.then((value) => null);
                    },
                  ),
                  WidgetMemu(
                    leadWidget:
                        const Icon(Icons.sentiment_very_dissatisfied_sharp),
                    titleWidget: const WidgetText(data: 'โรคประจำตัว :'),
                    tapFunc: () {
                      Get.back();
                      Get.to(const DiseaseList());
                    },
                  ),
                  WidgetMemu(
                    leadWidget: const Icon(Icons.history_rounded),
                    titleWidget: const WidgetText(data: 'ประวัติการแพ้ยา :'),
                    tapFunc: () {
                      Get.back();
                      Get.to(const HistoryDrugList());
                    },
                  ),
                  WidgetMemu(
                    leadWidget: const Icon(Icons.face_5),
                    titleWidget: const WidgetText(
                        data: 'รายละเอียดความพิการด้านดวงตาและการมองเห็น :'),
                    tapFunc: () {
                      Get.back();
                    },
                  ),
                  const Spacer(),
                  const WidgetSignOut(),
                ],
              ),
            ),
            body: bodys[appController.indexBody.value],
            bottomNavigationBar: BottomNavigationBar(
              items: items,
              currentIndex: appController.indexBody.value,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.blue.shade300,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                appController.indexBody.value = value;
              },
            ),
          );
        });
  }
}
