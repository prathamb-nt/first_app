import 'package:all_social_app/screens/create_posts/create_post_screen_step_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomAppBarExample(),

      body: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24,48,24,24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
               Text('Good Morning!\nJane Cooper',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Color(0xff1C1C1C)),
                ),
              ),
              SizedBox(
                width: 113,
              )
              ,
              Container(
                height: 46,
                width: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/profile_default.png",
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,55,0,0),
            child: Image.asset(
              "assets/home/no_posts.png",
              height: 342,
              width: 342,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,50),
            child: Text(
              "You don’t have create any posts.Please\ncreate new post.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff1C1C1C)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0, 0 ,10 ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePostScreenStep1()),
                );
              },
              child: Container(
                height: 40,
                width: 342,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  color: Color(0xffED4D86),
                ),
                child: Center(
                  child: Text('Create Post',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xffFFFFFC)),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
