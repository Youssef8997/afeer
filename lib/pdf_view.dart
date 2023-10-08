import 'package:afeer/utls/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../utls/widget/base_app_bar.dart';

class PdfView extends StatefulWidget {
  final String pdfLink;

  const PdfView({super.key, required this.pdfLink});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: context.width,
            height: context.height * .8,
            child:  PDF(
              swipeHorizontal: false,
              pageFling: true,
              autoSpacing: true,
              fitEachPage: true,
    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
      Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
      ),
    }
            ).cachedFromUrl(
              widget.pdfLink,
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
