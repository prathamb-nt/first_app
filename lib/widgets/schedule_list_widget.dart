import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/edit_post_screen.dart';
import 'package:all_social_app/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSchedulePosts extends StatelessWidget {
  const ShowSchedulePosts({
    super.key,
    required this.posts,
    required this.context,
    required this.textstyle,
  });

  final List<PostFire> posts;
  final BuildContext context;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 20),
          child: Text(
            "Schedule List",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color(0xff1C1C1C),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: posts.map((post) {
            return ListTile(
              title: GestureDetector(
                onTap: () {
                  debugPrint("${post.postId}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPost(
                        postTime: post.postTime,
                        displayImage: post.post,
                        postDate: post.postDate,
                        postPlatform: post.postPlatform,
                        postId: post.postId,
                      ),
                    ),
                  );
                },
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffFFFFFC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
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
                            padding: const EdgeInsets.only(left: 10.0, top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.postDate,
                                  style: textstyle,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    post.postPlatform,
                                    style: textstyle,
                                  ),
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
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class NoSchedulePosts extends StatelessWidget {
  const NoSchedulePosts({
    super.key,
    required this.widget,
  });

  final ScheduleWidget widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Center(
        child: Text(
          'No Posts Yet!',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
