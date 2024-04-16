import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfView extends StatefulWidget {
  final String pdfLink;

  const PdfView({super.key, required this.pdfLink});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, o) {
      return PDF(
          swipeHorizontal: false,
          pageFling: false,
          autoSpacing: false,
          fitEachPage: false,
          pageSnap: false,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          }).cachedFromUrl(
        widget.pdfLink,
        placeholder: (progress) => Center(
            child: Text(
          '$progress %',
          style: FontsManger.largeFont(context)
              ?.copyWith(color: ColorsManger.pColor, fontSize: 25),
        )),
        errorWidget: (error) => Center(child: Text(error.toString())),
      );
    });
  }
}
