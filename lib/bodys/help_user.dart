import 'dart:async';

import 'package:blindhelp/models/chat_model.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_form.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpUser extends StatefulWidget {
  const HelpUser({super.key});

  @override
  State<HelpUser> createState() => _HelpUserState();
}

class _HelpUserState extends State<HelpUser> {
  TextEditingController textEditingController = TextEditingController();
  AppController appController = Get.put(AppController());

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      streamSubscription;

  @override
  void initState() {
    super.initState();
    readChat();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  void readChat() {
    streamSubscription = FirebaseFirestore.instance
        .collection('user')
        .doc(appController.userModelLogins.last.uid)
        .collection('chat').orderBy('timestamp')
        .snapshots()
        .listen((event) {
      if (appController.chatModels.isNotEmpty) {
        appController.chatModels.clear();
      }

      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          ChatModel chatModel = ChatModel.fromMap(element.data());
          appController.chatModels.add(chatModel);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight-60 ,
            child: Obx(() {
              return appController.chatModels.isEmpty
                  ? const SizedBox()
                  : ListView.builder(reverse: false,
                      itemCount: appController.chatModels.length,
                      itemBuilder: (context, index) => BubbleSpecialThree(
                        text: appController.chatModels[index].message,
                        color: AppConstant.blue,
                        tail: true,
                        isSender: appController.userModelLogins.last.uid ==
                            appController.chatModels[index].uidSender,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    );
            }),
          ),
        );
      }),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WidgetForm(
              textEditingController: textEditingController,
              marginTop: 0,
              hint: 'ข้อความ',
            ),
            WidgetButton(
              size: 100,
              label: 'ส่ง',
              pressFunc: () {
                ChatModel chatModel = ChatModel(
                    message: textEditingController.text,
                    nameSender: appController.userModelLogins.last.name,
                    uidSender: appController.userModelLogins.last.uid,
                    urlSender:
                        appController.userModelLogins.last.urlAvatar ?? '',
                    timestamp: Timestamp.fromDate(DateTime.now()));

                AppService()
                    .addChat(map: chatModel.toMap())
                    .then((value) => textEditingController.text = '');
              },
              iconData: Icons.send,
            ),
          ],
        ),
      ),
    );
  }
}
