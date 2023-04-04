import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
  }

  play() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      isZoom = true;
    });
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      isStartTyping = true;
    });
  }

  bool isStartTyping = false;
  bool isShowContact = false;
  bool isZoom = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: h,
            width: w,
            constraints: BoxConstraints(minHeight: 600),
            color: Color.fromRGBO(230, 230, 244, 1),
          ),
          Positioned(
              child: Container(
            height: h * .3,
            constraints: BoxConstraints(minHeight: 280),
            width: w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 90, 73, 248),
                Color.fromARGB(255, 101, 86, 240),
              ]),
            ),
          )),
          Positioned(
            top: 0,
            child: Container(
                height: h,
                constraints: const BoxConstraints(minHeight: 600),
                width: w,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color.fromARGB(255, 208, 75, 75),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Stack(
                              children: [
                                const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Positioned(
                                    top: 1,
                                    right: 2,
                                    child: Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      AnimatedContainer(
                        curve: Curves.elasticOut,
                        height: isZoom ? 100 : 0,
                        width: isZoom ? w * .4 : 0,
                        duration: Duration(milliseconds: 2000),
                        child: Image.asset(
                          "assets/images/wlogo.png",
                          height: 100,
                          width: w * .4,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 500),
                        height: h * .7,
                        width: w * .88,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Welcome to HomePage",
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w400,
                                          fontSize: w > 1000 ? 20 : 14,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (isStartTyping)
                                    Expanded(
                                      child: TypeWriterText(
                                        duration: Duration(milliseconds: 15),
                                        text: Text(
                                          "Hi Wingman Team, \n\nThank you for giving me opportunity to complete this task as part of the interview process. This is just a sample of my work which is complete in one day. Please let me know if you have any questions or if there is anything else I can provide to support my candidacy for the position.\n\nAviral Dixit,",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: w > 1000 ? 20 : 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                if (isShowContact)
                                  InkWell(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          "mailto:aviral.dixit2910@gmail.com"));
                                    },
                                    child: Text(
                                      "Email: aviral.dixit2910@gmail.com",
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w400,
                                          fontSize: w > 1000 ? 20 : 14,
                                          color: Colors.blue),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (isShowContact)
                                  InkWell(
                                    onTap: () async {
                                      await launchUrl(
                                          Uri.parse("tel:+917007042761"));
                                    },
                                    child: Text(
                                      "Mobile: +917007042761",
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w400,
                                          fontSize: w > 1000 ? 20 : 14,
                                          color: Colors.blue),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowContact = !isShowContact;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 90, 73, 248),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isShowContact
                                            ? "Hide Contact"
                                            : "Show Contact",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w400,
                                            fontSize: w > 1000 ? 20 : 14,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
