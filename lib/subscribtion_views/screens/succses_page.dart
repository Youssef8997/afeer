import 'package:afeer/home_view/home_layout.dart';
import 'package:afeer/models/sub_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

class SuccsesPage extends StatefulWidget {
  final SubModel sub;
  const SuccsesPage({super.key, required this.sub});

  @override
  State<SuccsesPage> createState() => _SuccsesPageState();
}

class _SuccsesPageState extends State<SuccsesPage> {
  @override
  void initState() {
    context.appCuibt.addSubscribeTUser(widget.sub,context.appCuibt.user!,context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const AppBarWidget(),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 200),child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(Icons.done,color: Colors.green,size: 100,),
              const SizedBox(height: 20,),
              Text("لقد اتتمت اشتراكك بنجاح",style: FontsManger.largeFont(context)?.copyWith(fontSize: 23),),
              const SizedBox(height: 20,),
              SizedBox(height: context.height*.3,),

              ElevatedButton(onPressed: (){
                print(context.appCuibt.user?.token);
                context.appCuibt.addSubscribeTUser(widget.sub,context.appCuibt.user!,context);
navigatorWid(page: HomeScreen(),returnPage: false,context: context);
              }, child: const Text("الرئيسة"))

            ],
          ),)
        ],
      ),
    );
  }
}
