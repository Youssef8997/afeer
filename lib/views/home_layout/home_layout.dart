import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/views/home_layout/widget/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Scaffold(
        body: PageView(
          controller: context.appCuibt.page,
          physics: NeverScrollableScrollPhysics(),
          children: context.appCuibt.body,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      );
    });
  }
}
