import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/svg.dart';

import 'chat_view/screens/chat_screen.dart';
import 'home_view/home_layout.dart';
import 'news_view/screen/news_screen.dart';

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

      body: Column(
        children: [
          Container(
            height: 100,
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
                      bottom: 0, right: 20, top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          child: const Icon(CupertinoIcons.house_alt),
                          onTap: () => navigatorWid(
                              page: const HomeScreen(),
                              returnPage: true,
                              context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: SvgPicture.asset(
                            "assets/image/Notification---3.svg",
                            width: 10,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          onTap: () => navigatorWid(
                              page: const NewsScreen(),
                              returnPage: true,
                              context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: SvgPicture.asset(
                          "assets/image/Message---4.svg",
                          width: 10,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        onTap: () => navigatorWid(
                            page: const ChatScreen(),
                            context: context,
                            returnPage: true),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(
                    AssetsManger.logo2,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: const PDF(swipeHorizontal: true).cachedFromUrl(
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
