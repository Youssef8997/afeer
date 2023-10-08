import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';



import '../../utls/widget/base_widget.dart';
import '../../utls/widget/text_form.dart';
import '../widget/chat_call_widget.dart';
import '../widget/chat_list_widget.dart';
import '../widget/group_list_widget.dart';
import '../widget/tab_bar_widget.dart';
import 'massgae_personal_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController=TextEditingController();
  @override
  void initState() {
    context.appCuibt.getChatPersonal();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Color(0xffFCFCFE)),
      ),
      body: BlocConsumer<AppCubit,AppState>(
        builder: (context,state) {
          return ListView(
            children: [
             const AppBarWidget(),
 Padding(padding: const EdgeInsets.all(20),child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
  children: [
        Row(
          children: [
            TabBarWidget(name: "الأصدقاء",index: 1,),
            SizedBox(width: 20,),
            TabBarWidget(name: "المجموعات",index: 2,),
            SizedBox(width: 20,),
             TabBarWidget(name: "الدعم الفني",index: 3,),
          ],
    ),
    const Divider(
          color: Color(0xffE4E6EB),
    ),
    if(context.appCuibt.index==1)

       TextFormWidget(
        filledColor: const Color(0xffF0F2F5),
        label: "باستحدام الكود إبحث عن صديقك",
         controller: textEditingController,
onSumbted: (value){
          context.appCuibt.getInfoUser(value).then((va) {
            if(va!=null){
              context.appCuibt.createChaPersonal("", va.token).then((value) {
                navigatorWid(page:PersonalChatScreen(user: va,chat:value ),returnPage: true,context: context );

              });
            }else {
              MotionToast.error(description: const Text("عفوا هذا الشخص غير موجود ")).show(context);
            }

          });
},
      ),
    if(context.appCuibt.index==1)

      const SizedBox(height: 10,),
if(context.appCuibt.index==3)
  SizedBox(
    height: context.height*.8,
      width: context.width,
      child: ListView.separated(
          itemBuilder: (context, i) => CallChatListWidget(
              chatList: context.appCuibt.listChat[i]),
          separatorBuilder: (context, i) => const Divider(
            color: Colors.black12,
            height: 20,
          ),
          itemCount: context.appCuibt.listChat.length)),

    if(context.appCuibt.index==1)
      SizedBox(
          height: context.height*.8,
          width: context.width,
          child: ListView.separated(
              itemBuilder: (context, i) => ChatListWidget(
                  chatList: context.appCuibt.listChat[i]),
              separatorBuilder: (context, i) => const Divider(
                color: Colors.black12,
                height: 20,
              ),
              itemCount: context.appCuibt.listChat.length)),
    if(context.appCuibt.index==2)
      SizedBox(
          height: context.height*.8,
          width: context.width,
          child: ListView.separated(
              itemBuilder: (context, i) => ChatGroupListWidget(
                  chatList: context.appCuibt.listChat[i]),
              separatorBuilder: (context, i) => const Divider(
                color: Colors.black12,
                height: 20,
              ),
              itemCount: context.appCuibt.listChat.length)),
  ],
),)

            ],
          );
        },
        listener: (context,state){},
      ),
    );
  }
}
