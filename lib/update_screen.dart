import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.update,color: ColorsManger.pColor,size: 50,),
          const SizedBox(height: 20,),
          Text("برجاء تحديث التطبيق الخاص بك",style: FontsManger.largeFont(context),),
          const SizedBox(height: 20,),
Center(
  child:   ElevatedButton(onPressed: (){

    if (defaultTargetPlatform == TargetPlatform.android){

      context.appCuibt.launchUri(context.appCuibt.home.googleLink,context);

    }

    else if (defaultTargetPlatform == TargetPlatform.iOS){

      context.appCuibt.launchUri(context.appCuibt.home.iosLink,context);

    }



  }, child: const Text("تحديث")),
)
        ],
      ),
    );
  }
}
