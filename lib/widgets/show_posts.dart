import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/create_posts/frame_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({
    super.key,
    required this.posts,
    required this.textstyle,
  });

  final List<PostFire> posts;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 14.h),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Created Posts",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                children: posts.map((post) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: 390,
                        width: 342,
                        color: const Color(0xffFCE6EE),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 322,
                                width: 322,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Image.network(
                                      post.post,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Schedule: ${post.postDate}",
                                          style: textstyle,
                                        ),
                                        Text(
                                          post.postPlatform,
                                          style: textstyle,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      post.postTime,
                                      style: textstyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            ),
          ),
        ),
        Positioned(
            bottom: 6,
            right: 24,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: const Color(0xffED4D86),
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FrameSelectScreen(),
                  ),
                );
              },
              child: Center(
                child: SvgPicture.asset("assets/ic_plus.svg"),
              ),
            )),
      ],
    );
  }
}
