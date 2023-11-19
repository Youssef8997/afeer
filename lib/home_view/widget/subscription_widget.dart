import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../auth_views/screens/auth_home_screen.dart';
import '../../subscribtion_views/screens/subscription_screen.dart';
import '../../utls/manger/color_manger.dart';

class SubscriptionWidget extends StatefulWidget {
  final String name;
  final String disc;
  final String price;
  const SubscriptionWidget({super.key, required this.name, required this.disc, required this.price});

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(context.appCuibt.isVisitor==true){
          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false);
        }else {
          navigatorWid(page: const SubscriptionScreen(),context: context,returnPage: true);
        }

      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          SafeArea(
            minimum: const EdgeInsets.only(bottom: 15),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff707070),
                  width: .5
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,style:FontsManger.largeFont(context) ,),

                  Divider(color: ColorsManger.text3.withOpacity(.2),endIndent:context.width*.12 ),
                  SizedBox(
                      width: context.width*.7,
                      child: Text(widget.disc,style:FontsManger.mediumFont(context)?.copyWith(fontSize: 12,color: ColorsManger.text3) ,)),

                ],
              ),
            ),
          ),
          Positioned(left: 0,bottom: 0,child: Container(
            height: 30,
            width: 116,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManger.pColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            ),
            child: Text("اشترك الآن ${widget.price} ج.م",style: FontsManger.largeFont(context)?.copyWith(fontSize: 12,color: Colors.white)),
          ))
        ],
      ),
    );
  }
}
