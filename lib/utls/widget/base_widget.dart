import 'package:afeer/utls/extension.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationNav extends PageRouteBuilder {
  final Widget page;

  AnimationNav({
    required this.page,
  }) : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page,
      transitionDuration: const Duration(milliseconds: 200,),
      reverseTransitionDuration:const Duration(milliseconds: 200,),
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        // animation=CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn,reverseCurve:  Curves.fastOutSlowIn);
        return FadeScaleTransition(
          animation:animation ,
          child: page,
        );
//               return SharedAxisTransition(
//
//                   animation: animation,
//                   secondaryAnimation: secondaryAnimation,
//                   transitionType: SharedAxisTransitionType.horizontal,
//                   child: child);
      });
}
navigatorWid({required Widget page, context, returnPage = false, arguments}) {
  return Navigator.pushAndRemoveUntil(
    context,AnimationNav(page: page) , (Route route) => returnPage,
  );
}
class CircularProgressIndicatorWidget extends StatefulWidget {
  const CircularProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  State<CircularProgressIndicatorWidget> createState() => _CircularProgressIndicatorWidgetState();
}

class _CircularProgressIndicatorWidgetState extends State<CircularProgressIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      color: Colors.black.withOpacity(.1),
      child: const Center(
        child:   SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

void showLoading(context) {
  showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return const CircularProgressIndicatorWidget();
      },
      barrierColor: Colors.white.withOpacity(.1));
}