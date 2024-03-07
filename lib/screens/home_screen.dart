import 'dart:io';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/widgets/bottom_navbar.dart';
import 'package:all_social_app/widgets/show_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_posts/step_1_screen.dart';

class HomeScreen extends StatefulWidget {
  final String currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarExample(
        currentUser: widget.currentUser,
      ),
      body: HomeWidget(
        currentUser: widget.currentUser,
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  final String currentUser;

  const HomeWidget({
    super.key,
    required this.currentUser,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<Posts>> _postsFuture;

  @override
  void initState() {
    super.initState();
    DatabaseHelper().fetchData();
    _postsFuture = DatabaseHelper().getPosts(currentUserId);

    _postsFuture.then((posts) {
      if (posts.isNotEmpty) {
        setState(() {
          isFabVisible = true;
        });
      }
    });
  }

  late int currentUserId = int.parse(widget.currentUser);

  late String pickedImage = users!.userImage;
  Users? users;
  late String name;

  bool isFabVisible = false;

  int hours = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: FutureBuilder<Users?>(
            future: DatabaseHelper().getUserById(currentUserId),
            builder: (BuildContext context, AsyncSnapshot<Users?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                users = snapshot.data!;
                name = users!.userName!;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hours >= 1 && hours <= 12
                                ? 'Good Morning!\n$name'
                                : hours >= 12 && hours <= 16
                                    ? 'Good Afternoon!\n$name'
                                    : hours >= 16 && hours <= 21
                                        ? 'Good Evening!\n$name'
                                        : 'Good Night!\n$name',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Color(0xff1C1C1C),
                              ),
                            ),
                          ),
                          Container(
                            height: 46,
                            width: 46,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300.0),
                              child: Image.file(
                                File(pickedImage),
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<Posts>>(
                      future: _postsFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Posts>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final List<Posts>? posts = snapshot.data;
                          if (posts!.isEmpty) {
                            return NoPosts(widget: widget);
                          } else {
                            return ShowPosts(posts: posts);
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
                );
              } else {
                return const Center(
                  child: Text('no data'),
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 6,
          right: 24,
          child: isFabVisible == true
              ? FloatingActionButton(
                  heroTag: null,
                  backgroundColor: const Color(0xffED4D86),
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePostScreenStep1(
                          currentUser: widget.currentUser,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: SvgPicture.asset("assets/ic_plus.svg"),
                  ),
                )
              : Container(
                  color: Colors.transparent,
                ),
        )
      ],
    );
  }
}

class NoPosts extends StatelessWidget {
  const NoPosts({
    super.key,
    required this.widget,
  });

  final HomeWidget widget;

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePostScreenStep1(
                    currentUser: widget.currentUser,
                  ),
                ),
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
