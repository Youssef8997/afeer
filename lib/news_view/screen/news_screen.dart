import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../auth_views/screens/auth_home_screen.dart';
import '../../chat_view/screens/chat_screen.dart';
import '../../settings_views/screen/settings_screen.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/widget/base_widget.dart';
import '../widget/post_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
context.appCuibt.getPosts();
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
      body: ListView(
        children: [
          Container(
            height: 80,
            decoration:
                BoxDecoration(color: const Color(0xffFCFCFE), boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.16),
                  offset: const Offset(0, 3),
                  blurRadius: 6)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0, right: 15, top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(child: Image.asset("assets/image/Container.png",width: 20,height: 35,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const SettingsScreen(),returnPage: true,context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                          onTap: () => Navigator.pop(context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(child: SvgPicture.asset("assets/image/Message---4.svg",width: 10,height: 30,fit: BoxFit.cover,)
                        ,
                        onTap: () =>context.appCuibt.isVisitor?navigatorWid(
                            page: const AuthHomeScreen(),
                            context: context,
                            returnPage: true): navigatorWid(
                            page: const ChatScreen(),
                            context: context,
                            returnPage: true),                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Image.asset(
                    AssetsManger.logo2,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AppCubit,AppState>(
              builder: (context,state) {
                return Column(
                  children: [
   for(int i =0;i<context.appCuibt.posts.length;i++)
     PostWidget(post: context.appCuibt.posts[i],)


                  ],
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
