import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wingman/pages/Onboarding/LoginPage.dart';
import 'package:wingman/pages/screens/HomePage.dart';
import 'package:wingman/service/apiService.dart';

class NewUserPage extends StatefulWidget {
  NewUserPage({super.key, required this.token});
  String token;
  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
  }

  play() async {
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      isPop = true;
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  ApiService apiService = ApiService();
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
              height: h,
              constraints: BoxConstraints(minHeight: 650),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(237, 101, 86, 240),
                      Color.fromARGB(236, 207, 203, 244),
                      Color.fromARGB(237, 101, 86, 240),
                    ]),
              ),
            ),
            AnimatedPositioned(
              left: isPop ? 0 : w,
              duration: Duration(milliseconds: 1200),
              top: h * .125,
              curve: Curves.elasticOut,
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(230, 230, 244, 1)),
                  height: h * .75,
                  constraints: BoxConstraints(minHeight: 500),
                  width: w,
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
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
                              height: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Welcome",
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
                                  "Looks like you are new here. Tell us a bitabout yourself.",
                                  style: GoogleFonts.abel(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                  child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.abel(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900),
                                cursorColor:
                                    const Color.fromARGB(255, 90, 73, 248),
                                decoration: InputDecoration(
                                  hintText: "Enter Name",
                                  hintStyle: GoogleFonts.abel(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600),
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15, right: 15),
                                  focusedBorder: const OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.transparent),
                                  ),
                                ),
                              )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                  child: TextFormField(
                                controller: mail,
                                keyboardType: TextInputType.text,
                                style: GoogleFonts.abel(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900),
                                cursorColor:
                                    const Color.fromARGB(255, 90, 73, 248),
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  hintStyle: GoogleFonts.abel(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600),
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15, right: 15),
                                  focusedBorder: const OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.transparent),
                                  ),
                                ),
                              )),
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
                                  if (name.text.isEmpty || mail.text.isEmpty) {
                                    showToast(
                                      "Name or Email cannot be empty",
                                      context: context,
                                      toastHorizontalMargin: 10,
                                      backgroundColor:
                                          Color.fromARGB(255, 209, 45, 23),
                                      position: const StyledToastPosition(
                                          align: Alignment.bottomRight,
                                          offset: 10),
                                      animation: StyledToastAnimation.scale,
                                    );
                                  } else {
                                    try {
                                      print(widget.token);
                                      var result =
                                          await apiService.submitProfile(
                                              name.text,
                                              mail.text,
                                              widget.token);
                                      if (result["status"]) {
                                        Navigator.of(context)
                                          ..pushReplacement(PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              child: const HomePage(),
                                              type: PageTransitionType.fade));
                                      } else {
                                        showToast(
                                          "Unale to Submit, Try Again!",
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
                                    } catch (e) {
                                      showToast(
                                        "Unale to Submit, Try Again!",
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
                                    child: Text(
                                      "submit".toUpperCase(),
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
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
          ],
        ),
      ),
    );
  }
}
