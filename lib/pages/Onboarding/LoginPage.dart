import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wingman/pages/Onboarding/OtpPage.dart';
import 'package:wingman/service/apiService.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isTextTap = false;
TextEditingController phoneNumber = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
  }

  play() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      isPop = true;
    });
  }

  timerUp() async {
    for (int i = 1; i <= 15; i++) {
      await Future.delayed(Duration(seconds: 1));
      if (i == 15) {
        setState(() {
          isOtpSentLoading = false;
          timerr = 15;
        });
      } else {
        setState(() {
          timerr = 15 - i;
        });
      }
    }
  }

  int timerr = 15;
  bool isOtpSentLoading = false;
  ApiService apiService = ApiService();
  bool isPop = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: w,
              height: h,
              constraints: BoxConstraints(minHeight: 650),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color.fromARGB(237, 101, 86, 240),
                    ]),
              ),
            ),
            AnimatedPositioned(
              left: 0,
              duration: Duration(milliseconds: 1200),
              top: isPop ? -200 : -h,
              curve: Curves.elasticOut,
              child: Card(
                elevation: 20,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(230, 230, 244, 1)),
                  height: h * .9 + 200,
                  width: w,
                  constraints: BoxConstraints(minHeight: 750),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 300,
                          ),
                          Image.asset(
                            "assets/images/clogo.png",
                            height: 50,
                            // width: 200,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Get ",
                                      style: GoogleFonts.abel(
                                          color: Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "Started",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ),
                              InputField(isTextTap: isTextTap)
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (isOtpSentLoading)
                            SizedBox(
                              width: w * .8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Try again in : ",
                                    style: GoogleFonts.abel(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "$timerr",
                                    style: GoogleFonts.abel(
                                        color: Color.fromARGB(255, 90, 73, 248),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InkWell(
                              onTap: () async {
                                if (isTextTap) {
                                  if (phoneNumber.text.length == 10) {
                                    try {
                                      setState(() {
                                        isOtpSentLoading = true;
                                      });
                                      timerUp();
                                      var result = await apiService
                                          .getOtp(phoneNumber.text);
                                      print(result);
                                      setState(() {
                                        isOtpSentLoading = false;
                                      });
                                      Navigator.of(context).pushReplacement(
                                          PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              child: OtpPage(
                                                reqId: result["request_id"],
                                              ),
                                              childCurrent: Container(
                                                width: w,
                                                height: h,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.white,
                                                        Color.fromARGB(
                                                            237, 101, 86, 240),
                                                      ]),
                                                ),
                                              ),
                                              type: PageTransitionType
                                                  .bottomToTopJoined));
                                    } catch (e) {
                                      setState(() {
                                        isOtpSentLoading = true;
                                      });
                                    }
                                  } else {
                                    showToast(
                                      'Enter valid Phone Number',
                                      context: context,
                                      toastHorizontalMargin: 10,
                                      backgroundColor:
                                          Color.fromARGB(255, 209, 45, 23),
                                      position: const StyledToastPosition(
                                          align: Alignment.bottomRight,
                                          offset: 10),
                                      animation: StyledToastAnimation.scale,
                                    );
                                  }
                                }
                                setState(() {
                                  isTextTap = true;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: w * .8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 90, 73, 248),
                                    Color.fromARGB(237, 101, 86, 240),
                                  ]),
                                ),
                                child: Center(
                                  child: isOtpSentLoading
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          isTextTap
                                              ? "CONTINUE"
                                              : "Login".toUpperCase(),
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  InputField({super.key, required this.isTextTap});
  bool isTextTap;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: 50,
          width: w * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 90, 73, 248),
              Color.fromARGB(237, 101, 86, 240),
            ]),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    "+91",
                    style: GoogleFonts.abel(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Container(
                height: 50,
                width: w * .8 - 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                    child: TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.abel(
                      color: Colors.black,
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600),
                  cursorColor: const Color.fromARGB(255, 90, 73, 248),
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    hintStyle: GoogleFonts.abel(
                        color: Colors.grey,
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    focusedBorder: const OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide:
                          BorderSide(width: 3, color: Colors.transparent),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
        if (!widget.isTextTap)
          Positioned(
            child: Container(
              height: 50,
              width: w * .8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Color.fromRGBO(230, 230, 244, 1)),
            ),
          )
      ],
    );
  }
}
