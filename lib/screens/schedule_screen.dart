import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/edit_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleWidget extends StatefulWidget {
  final String displayImage;
  final String imageText;
  final String currentUser;

  const ScheduleWidget({
    super.key,
    required this.currentUser,
    required this.displayImage,
    required this.imageText,
  });

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  late Future<List<Posts>> _postsFuture;

  @override
  void initState() {
    super.initState();
    DatabaseHelper().fetchData();
    _postsFuture = DatabaseHelper().getPosts(currentUserId);
  }

  late int currentUserId = int.parse(widget.currentUser);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
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
          FutureBuilder<List<Posts>>(
            future: _postsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final List<Posts>? posts = snapshot.data;
                if (posts!.isEmpty) {
                  return NoSchedulePosts(widget: widget);
                } else {
                  return ShowSchedulePosts(
                    posts: posts,
                    displayImage: widget.displayImage,
                    imageText: widget.imageText,
                    currentUser: widget.currentUser,
                  );
                }
              } else {
                return Container(
                  color: Colors.red,
                  height: 550,
                  width: 500,
                );
              }
            },
          ),
        ],
      ),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
          child: SvgPicture.asset(
            "assets/no_posts_default_image.svg",
            height: 342,
            width: 342,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
          child: Text(
            "You don’t have create any posts. Please\ncreate a new post.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff1C1C1C),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: GestureDetector(
            onTap: () {},
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
                child: Text(
                  'Create Post',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xffFFFFFC),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShowSchedulePosts extends StatefulWidget {
  final String displayImage;
  final String imageText;
  final String currentUser;

  ShowSchedulePosts({
    super.key,
    required this.posts,
    required this.displayImage,
    required this.imageText,
    required this.currentUser,
  });

  final List<Posts>? posts;

  @override
  State<ShowSchedulePosts> createState() => _ShowSchedulePostsState();
}

class _ShowSchedulePostsState extends State<ShowSchedulePosts> {
  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.posts!.map<Widget>(
        (Posts post) {
          return ListTile(
            title: GestureDetector(
              onTap: () {
                print(post.postId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPost(
                      currentUser: widget.currentUser,
                      postTime: post.postTime,
                      displayImage: post.post,
                      postDate: post.postDate,
                      postPlatform: post.postPlatform,
                      postId: post.postId,
                    ),
                  ),
                );
              },
              child: Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: Image.memory(
                                post.post,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   width: 206,
                              //   child: Text(
                              //     widget.imageText,
                              //     softWrap: true,
                              //     style: GoogleFonts.montserrat(
                              //       textStyle: textstyle,
                              //     ),
                              //   ),
                              // ),
                              Text(
                                post.postDate,
                                style: textstyle,
                              ),
                              Text(
                                post.postPlatform,
                                style: textstyle,
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
        },
      ).toList(),
    );
  }
}
