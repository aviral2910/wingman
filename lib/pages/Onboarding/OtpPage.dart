import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wingman/pages/Onboarding/LoginPage.dart';
import 'package:wingman/pages/Onboarding/NewUser.dart';
import 'package:wingman/pages/screens/HomePage.dart';
import 'package:wingman/service/apiService.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key, required this.reqId});
  String reqId;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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

  String verficationCode = "";
  ApiService apiService = ApiService();
  bool isOtpVerifing = false;
  bool isPop = false;
  bool isTextTap = false;
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
              constraints: BoxConstraints(minHeight: 650),
              height: h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(237, 101, 86, 240),
                      Colors.white,
                    ]),
              ),
            ),
            AnimatedPositioned(
              left: 0,
              duration: Duration(milliseconds: 1200),
              top: isPop ? h * .12 : h,
              curve: Curves.elasticOut,
              child: Card(
                elevation: 20,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(230, 230, 244, 1)),
                  height: h * .9 + 200,
                  constraints: BoxConstraints(minHeight: 750),
                  width: w,
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: h * .9 - 60,
                      constraints: BoxConstraints(minHeight: 550),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Enter ",
                                        style: GoogleFonts.abel(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        "OTP",
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "OTP has been sent to +91-number",
                                    style: GoogleFonts.abel(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              OtpTextField(
                                cursorColor: Color(0xFF512DA8),
                                filled: true,
                                textStyle: GoogleFonts.abel(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                                fillColor: Color.fromARGB(51, 90, 73, 248),
                                numberOfFields: 6,
                                borderColor: Color(0xFF512DA8),
                                disabledBorderColor: Colors.amber,
                                //set to true to show as box or false to show as dash
                                showFieldAsBox: true,
                                //runs when a code is typed in
                                onCodeChanged: (String code) {
                                  //handle validation or checks here
                                },
                                //runs when every textfield is filled
                                onSubmit: (String verificationCode) async {
                                  setState(() {
                                    isOtpVerifing = true;
                                    verficationCode = verificationCode;
                                  });
                                  try {
                                    var result = await apiService.verifyOtp(
                                        widget.reqId, verificationCode);
                                    if (result["status"] == true) {
                                      if (result["profile_exists"] == true) {
                                        setState(() {
                                          isOtpVerifing = false;
                                        });
                                        Navigator.of(context).pushReplacement(
                                            PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                child: const HomePage(),
                                                type: PageTransitionType.fade));
                                      } else {
                                        setState(() {
                                          isOtpVerifing = false;
                                        });
                                        Navigator.of(context).pushReplacement(
                                            PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                child: NewUserPage(
                                                  token: result["jwt"],
                                                ),
                                                childCurrent: Scaffold(
                                                  body: Container(
                                                    width: w,
                                                    height: h,
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromARGB(237,
                                                                101, 86, 240),
                                                            Color.fromARGB(236,
                                                                207, 203, 244),
                                                            Color.fromARGB(237,
                                                                101, 86, 240),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeftJoined));
                                      }
                                    } else {
                                      showToast(
                                        'Verification Failed, Try Again!',
                                        context: context,
                                        toastHorizontalMargin: 10,
                                        backgroundColor:
                                            Color.fromARGB(255, 209, 45, 23),
                                        position: const StyledToastPosition(
                                            align: Alignment.bottomRight,
                                            offset: 10),
                                        animation: StyledToastAnimation.scale,
                                      );
                                      setState(() {
                                        isOtpVerifing = false;
                                      });
                                      Navigator.of(context).pushReplacement(
                                          PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              child: const LoginPage(),
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
                                                        Color.fromARGB(
                                                            237, 101, 86, 240),
                                                        Colors.white,
                                                      ]),
                                                ),
                                              ),
                                              type: PageTransitionType
                                                  .topToBottomJoined));
                                    }
                                  } catch (e) {
                                    showToast(
                                      'Try Again!',
                                      context: context,
                                      toastHorizontalMargin: 10,
                                      backgroundColor:
                                          Color.fromARGB(255, 209, 45, 23),
                                      position: const StyledToastPosition(
                                          align: Alignment.bottomRight,
                                          offset: 10),
                                      animation: StyledToastAnimation.scale,
                                    );
                                    setState(() {
                                      isOtpVerifing = false;
                                    });
                                  }
                                }, // end onSubmit
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (verficationCode.length == 6) {
                                      setState(() {
                                        isOtpVerifing = true;
                                      });
                                      try {
                                        var result = await apiService.verifyOtp(
                                            widget.reqId, verficationCode);
                                        if (result["status"] == true) {
                                          if (result["profile_exists"] ==
                                              true) {
                                            setState(() {
                                              isOtpVerifing = false;
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                    child: const HomePage(),
                                                    type: PageTransitionType
                                                        .fade));
                                          } else {
                                            setState(() {
                                              isOtpVerifing = false;
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                    child: NewUserPage(
                                                      token: result["token"],
                                                    ),
                                                    childCurrent: Scaffold(
                                                      body: Container(
                                                        width: w,
                                                        height: h,
                                                        decoration:
                                                            const BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromARGB(
                                                                    237,
                                                                    101,
                                                                    86,
                                                                    240),
                                                                Color.fromARGB(
                                                                    236,
                                                                    207,
                                                                    203,
                                                                    244),
                                                                Color.fromARGB(
                                                                    237,
                                                                    101,
                                                                    86,
                                                                    240),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeftJoined));
                                          }
                                        } else {
                                          showToast(
                                            'Verification Failed, Try Again!',
                                            context: context,
                                            toastHorizontalMargin: 10,
                                            backgroundColor: Color.fromARGB(
                                                255, 209, 45, 23),
                                            position: const StyledToastPosition(
                                                align: Alignment.bottomRight,
                                                offset: 10),
                                            animation:
                                                StyledToastAnimation.scale,
                                          );
                                          setState(() {
                                            isOtpVerifing = false;
                                          });
                                          Navigator.of(context).pushReplacement(
                                              PageTransition(
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  child: const LoginPage(),
                                                  childCurrent: Container(
                                                    width: w,
                                                    height: h,
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromARGB(237,
                                                                101, 86, 240),
                                                            Colors.white,
                                                          ]),
                                                    ),
                                                  ),
                                                  type: PageTransitionType
                                                      .topToBottomJoined));
                                        }
                                      } catch (e) {
                                        showToast(
                                          'Try Again!',
                                          context: context,
                                          toastHorizontalMargin: 10,
                                          backgroundColor:
                                              Color.fromARGB(255, 209, 45, 23),
                                          position: const StyledToastPosition(
                                              align: Alignment.bottomRight,
                                              offset: 10),
                                          animation: StyledToastAnimation.scale,
                                        );
                                        setState(() {
                                          isOtpVerifing = false;
                                        });
                                      }
                                    } else {
                                      showToast(
                                        'Enter Otp',
                                        context: context,
                                        toastHorizontalMargin: 10,
                                        backgroundColor:
                                            Color.fromARGB(255, 209, 45, 23),
                                        position: const StyledToastPosition(
                                            align: Alignment.bottomRight,
                                            offset: 10),
                                        animation: StyledToastAnimation.scale,
                                      );
                                      setState(() {
                                        isOtpVerifing = false;
                                      });
                                    }
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
                                      child: isOtpVerifing
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              "Verify".toUpperCase(),
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 8.0, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              child: const LoginPage(),
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
                                                        Color.fromARGB(
                                                            237, 101, 86, 240),
                                                        Colors.white,
                                                      ]),
                                                ),
                                              ),
                                              type: PageTransitionType
                                                  .topToBottomJoined));
                                    },
                                    child: Text(
                                      "Retry",
                                      style: GoogleFonts.aBeeZee(
                                          color:
                                              Color.fromARGB(255, 90, 73, 248),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
