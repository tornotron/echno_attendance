import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:echno_attendance/camera/camera_provider.dart';
import 'package:echno_attendance/camera/camera_screen.dart';
import 'package:echno_attendance/user/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:echno_attendance/user/widgets/rounded_card.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomePage extends StatefulWidget {
  final String appbarUserName;
  const HomePage({super.key, required this.appbarUserName});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Color(0xFF004AAD)),
          leading: const Icon(
            Icons.account_circle_rounded,
            size: 35,
          ),
          actions: [
            Center(
              child: Text(
                widget.appbarUserName,
                style: const TextStyle(
                    fontFamily: 'TT Chocolates',
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          backgroundColor: const Color(0xFF004AAD),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                    backgroundColor: Color(0xFF38B6FF),
                    expandedHeight: 200,
                    floating: true,
                    pinned: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts(
                                textData: "Welcome",
                                textFontSize: 28,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Texts(
                                textData: "Site Name",
                                textFontSize: 20,
                              ),
                              SizedBox(
                                height: 2.5,
                              ),
                              Texts(
                                textData: "Site Location",
                                textFontSize: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 25),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 70),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: RoundedCard(),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        );
                      },
                      childCount: 9,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 85),
                child: SlideAction(
                  elevation: 0,
                  outerColor: const Color(0xFF004AAD),
                  text: 'Slide to mark attendance',
                  textStyle: const TextStyle(
                      fontFamily: 'TT Chocolates',
                      fontSize: 20,
                      color: Colors.white),
                  sliderRotate: false,
                  borderRadius: 20,
                  sliderButtonIcon: const Icon(
                    Icons.camera_alt,
                    color: Color(0xFF004AAD),
                  ),
                  onSubmit: () async {
                    final frontCamera = await cameraObjectProvider();
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen(camera: frontCamera),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF004AAD),
          items: [
            SizedBox(
              child: Image.asset(
                'assets/icons/Calendar.png',
                scale: 50,
              ),
            ),
            SizedBox(
              child: Image.asset(
                'assets/icons/Checkmark.png',
                scale: 50,
              ),
            ),
            SizedBox(
              child: Image.asset(
                'assets/icons/Home.png',
                scale: 50,
              ),
            ),
            SizedBox(
              child: Image.asset(
                'assets/icons/Uparrow.png',
                scale: 50,
              ),
            ),
            SizedBox(
              child: Image.asset(
                'assets/icons/Profile.png',
                scale: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
