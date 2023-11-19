import 'package:afeer/subscribtion_views/widget/sub_widget.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:  [
          const   AppBarWidget(),
          const  SizedBox(height: 30,),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context,i)=>SubscriptionWidget(sub: context.appCuibt.subList[i]), separatorBuilder: (context,i)=>const SizedBox(height: 20), itemCount: context.appCuibt.subList.length))
        ],
      ),
    );
  }
}
