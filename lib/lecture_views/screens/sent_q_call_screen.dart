import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:flutter/material.dart';


class SentQCallScreen extends StatefulWidget {
  const SentQCallScreen({super.key});

  @override
  State<SentQCallScreen> createState() => _SentQCallScreenState();
}

class _SentQCallScreenState extends State<SentQCallScreen> {
  TextEditingController massage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "اطرح سؤالك ؟",
              style: FontsManger.largeFont(context)
                  ?.copyWith(color: ColorsManger.pColor),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller:massage,
            maxLines: 7,
            decoration: InputDecoration(
              hintText:"ماهوا سؤالك",
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              hintStyle:FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3.withOpacity(.20)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Color(0xff707070))),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Color(0xff707070))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Color(0xff707070))),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Color(0xff707070))),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width:1,color: Colors.red.withOpacity(.4))),

            ),

          ),
          Padding(
            padding: const EdgeInsets.all(35),
            child: ElevatedButton(
                onPressed: () => context.appCuibt
                    .createChatCallCanter(massage.text)
                    .then((value) => Navigator.pop(context)),
                child: const Text("ارسال")),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    massage.dispose();
    super.dispose();
  }
}
