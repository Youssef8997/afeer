import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final String name;
  final int index;
  const TabBarWidget({super.key, required this.name, required this.index});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          context.appCuibt.index=widget.index;

        });
        context.appCuibt.changeIndex(widget.index);
if( context.appCuibt.index==3){
  context.appCuibt.getChatCallCanter();
}
if( context.appCuibt.index==1){
  context.appCuibt.getChatPersonal();
}
if( context.appCuibt.index==2){
  context.appCuibt.getGroupChat();
}

      },
      child: Column(
        children: [
          Text(widget.name,style: FontsManger.largeFont(context)?.copyWith(
            color: widget.index== context.appCuibt.index?ColorsManger.pColor:Colors.black
          ),),
          const SizedBox(height: 5,),
          if(widget.index==context.appCuibt.index)
          Container(height:2 ,width: 50,color: ColorsManger.pColor,)
        ],
      ),
    );
  }
}
