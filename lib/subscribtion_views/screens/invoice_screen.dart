import 'dart:io';

import 'package:afeer/models/sub_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pay/pay.dart';

import '../../models/academic_year_model.dart';
import '../../utls/payment_configurations.dart';

class InVoiceScreen extends StatefulWidget {
  final SubModel sub;

  const InVoiceScreen({super.key, required this.sub});

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen> {
  String payment = "كاش";

  @override
  void initState() {
    context.appCuibt.subject = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const AppBarWidget(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.sub.isASingleSubject == true)
                  Text(
                    "اختار المواد!",
                    style: FontsManger.largeFont(context)
                        ?.copyWith(color: ColorsManger.pColor),
                  ),
                if (widget.sub.isASingleSubject == true)
                  for (int i = 0; i < context.appCuibt.subjectList.length; i++,)
                    CheckboxListTile(
                      value: context.appCuibt.subject
                          .contains(context.appCuibt.subjectList[i].name),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            if (context.appCuibt.subject.length <
                                widget.sub.countSub!) {
                              context.appCuibt.subject
                                  .add(context.appCuibt.subjectList[i].name);
                            } else {
                              MotionToast.warning(
                                title: Text(
                                    "عفوا لا يمكن اضافه اكثر من ${widget.sub.countSub} مادة"),
                                description:
                                    const Text("يمكنك الاشتراك  ف باقه اخري!"),
                              ).show(context);
                            }
                          } else {
                            context.appCuibt.subject
                                .remove(context.appCuibt.subjectList[i].name);
                          }
                        });
                      },
                      title: Text(context.appCuibt.subjectList[i].name,
                          style: FontsManger.largeFont(context)),
                    ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "اختار طريقة الدفع !",
                  style: FontsManger.largeFont(context)
                      ?.copyWith(color: ColorsManger.pColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (context.appCuibt.home.pay.contains("visa"))
                  ListTile(
                    title: const Text("بطافات الدفع"),
                    trailing: const Icon(Icons.credit_card,
                        color: ColorsManger.text1),
                    leading: Checkbox(
                        onChanged: (value) {
                          setState(() {
                            if (payment == "بطافات الدفع") {
                              payment = "كاش";
                            } else {
                              payment = "بطافات الدفع";
                            }
                          });
                        },
                        value: payment == "بطافات الدفع"),
                  ),
                if (context.appCuibt.home.pay.contains("Apple pay"))
                  ApplePayButton(
                    paymentConfiguration: PaymentConfiguration.fromJsonString(
                        defaultApplePay),
                    paymentItems: [
                      PaymentItem(
                        label: 'Total',
                        amount: '0.01',
                        status: PaymentItemStatus.final_price,
                      )
                    ],
                    style: ApplePayButtonStyle.black,
                    type: ApplePayButtonType.subscribe,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (re){
                      print(re);
                    },
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ListTile(
                  title: const Text("كاش"),
                  trailing:
                      const Icon(Icons.attach_money, color: ColorsManger.text1),
                  leading: Checkbox(
                      onChanged: (value) {
                        setState(() {
                          if (payment == "كاش") {
                            payment = "بطافات الدفع";
                          } else {
                            payment = "كاش";
                          }
                        });
                      },
                      value: payment == "كاش"),
                ),
                SizedBox(
                  height: context.height * .2,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (payment == "بطافات الدفع") {
                        if (context.appCuibt.subject.length ==
                            widget.sub.countSub) {
                          showLoading(context);

                          context.appCuibt.getFirstToken(
                              double.parse(widget.sub.price),
                              context,
                              widget.sub);
                        } else {
                          MotionToast.error(
                                  description: Text(
                                      "يجب اختيار ${widget.sub.countSub} مواد "))
                              .show(context);
                        }
                      } else if (payment == "كاش") {
                        showDialog(
                            context: context,
                            useRootNavigator: false,
                            builder: (ctx) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: context.width * .3,
                                  height: context.height * .3,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "للإشتراك في الباقة يرجى التواصل مع أي رقم من الأرقام التالية\n 01117058113 \n 01117058155 \n 01208618618",
                                          style:
                                              FontsManger.largeFont(context)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: Theme.of(context)
                                            .elevatedButtonTheme
                                            .style
                                            ?.copyWith(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.red)),
                                        child: const Text("الرجوع"),
                                      )
                                    ],
                                  ),
                                )));
                      } else {}
                    },
                    child: const Text("إدفع"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
