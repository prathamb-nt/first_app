import 'package:all_social_app/models/users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPosts extends StatelessWidget {
  ShowPosts({
    super.key,
    required this.posts,
  });

  final List<Posts>? posts;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posts!.map<Widget>(
            (Posts post) {
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
                                child: Image.memory(
                                  post.post,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
            },
          ).toList(),
        ),
      ],
    );
  }
}
