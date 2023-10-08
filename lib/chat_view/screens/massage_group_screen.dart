import 'package:afeer/utls/extension.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/chat_list_model.dart';
import '../../../models/chat_model.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/base_app_Bar.dart';
import '../widget/admin_chat.dart';
import '../widget/user_chat_widget.dart';

class GroupChat extends StatefulWidget {
  final  ChatListModel chat;

  const GroupChat({super.key, required this.chat,});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  ScrollController scrollController=ScrollController();
  TextEditingController textEditingController=TextEditingController();
  int size=0;
  bool isFirstOpen=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const AppBarWidget(),
          Container(
            height: 60,
            width: context.width,
            color: const Color(0xffF0F2F5),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [

                const SizedBox(width: 10,),
                Text(widget.chat.idUser1,style: FontsManger.largeFont(context)?.copyWith(
                    fontSize: 12
                ),),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_forward_ios,color: Color(0xff374AE0),))
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Groups")
                  .doc(context.appCuibt.user?.typeStudy)
                  .collection(context.appCuibt.user!.university).doc(widget.chat.chatId).collection("massage")
                  .orderBy("time")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    controller: scrollController,
                    itemBuilder: (context, i) {
                      if (i + 1 == size) {
                        if (isFirstOpen) {
                          isFirstOpen = false;
                        }
                      }
                      if (snapshot.data?.size != size) {
                        if(isFirstOpen==false){
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent+45,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        }

                        size=snapshot.data?.size??0;
                      }
                      if (snapshot.data!.docs[i].get("senderId")!=
                          context.appCuibt.user?.token) {
                        MassageModel chat = MassageModel.fromJson(
                            snapshot.data!.docs[i].data()
                            as Map<String, dynamic>);
                        return UserWidgetChat(
                          chat: chat,
                        );
                      } else {

                        MassageModel chat = MassageModel.fromJson(
                            snapshot.data!.docs[i].data()
                            as Map<String, dynamic>);
                        return AdminWidgetChat(
                            chat: chat
                        );
                      }
                    },
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, _) =>
                    const SizedBox(height: 10),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ColorsManger.scaffoldBackGround,
              ),
              height: 50,
              child: TextFormField(
                style: FontsManger.mediumFont(context)?.copyWith(
                    color: ColorsManger.black, fontSize: 24),
                controller: textEditingController,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      context.appCuibt.sendChatGroup(
                          massage:  MassageModel(time: Timestamp.now(),massage:textEditingController.text,senderId: context.appCuibt.user!.token ),
                          chatId:  widget.chat.chatId,
                          university: context.appCuibt.user?.university,
                          filed: context.appCuibt.user?.typeStudy

                      );
                      textEditingController.clear();
                    },
                    child: Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorsManger.pColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                            child: Icon(
                              Icons.send,
                              color: ColorsManger.white,
                            ))),
                  ),
                  alignLabelWithHint: true,
                  hintStyle: FontsManger.mediumFont(context),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          width: 1, color: Colors.black87)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          width: 1, color: Colors.black87)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          width: 1, color: Colors.black87)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          width: 1, color: Colors.black87)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.red.withOpacity(.4))),
                ),
              )),
        ],
      ),
    );
  }
}
