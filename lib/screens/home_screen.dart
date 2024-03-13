import 'dart:io';
import 'dart:typed_data';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/widgets/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_posts/step_1_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? displayImage;
  final String? imageText;
  final String? currentUser;
  final String? currentDocId;
  const HomeScreen(
      {super.key,
      this.currentUser,
      this.displayImage,
      this.imageText,
      this.currentDocId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomAppBarWidget(
        currentUser: "1",
        displayImage:
            "/data/user/0/com.example.all_social_app/cache/b224685d-6deb-42b2-9fb4-afeee7fbd4c5/IMG_20240308_115252.jpg",
        imageText:
            "/data/user/0/com.example.all_social_app/cache/b224685d-6deb-42b2-9fb4-afeee7fbd4c5/IMG_20240308_115252.jpg",
      ),
      body: HomeWidget(
        currentUser: "1",
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
    readUser();
    fetchPosts().then((posts) {
      if (posts.isNotEmpty) {
        setState(() {
          isFabVisible = true;
        });
      }
    });
    _postsFuture.then((posts) {
      if (posts.isNotEmpty) {
        setState(() {
          isFabVisible = true;
        });
      }
    });
  }

  late int currentUserId = int.parse(widget.currentUser);

  Users? users;
  late String name;

  bool isFabVisible = false;
  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );
  int hours = DateTime.now().hour;
  late String docId = "docSnapshot.id";
  Future<UserFire?> readUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          docId = docSnapshot.id;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    final docUser = FirebaseFirestore.instance.collection('users').doc(docId);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserFire.fromJson(snapshot.data()!);
    }
  }

  Future<List<PostFire>> fetchPosts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return PostFire.fromJson(data);
    }).toList();
  }

  Future<Widget> _buildPosts() async {
    final posts = await fetchPosts();
    if (posts.isEmpty) {
      return NoPosts(widget: widget);
    } else {
      return Column(
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
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child:
              // FutureBuilder(
              //     future: readUser(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         final user = snapshot.data;
              //         return Text(user!.userName);
              //       }
              //       return const CircularProgressIndicator();
              //     }),
              FutureBuilder(
            future: readUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final userName = snapshot.data?.userName;
                final image = snapshot.data?.profileImage;

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
                                ? 'Good Morning!\n$userName'
                                : hours >= 12 && hours <= 16
                                    ? 'Good Afternoon!\n$userName'
                                    : hours >= 16 && hours <= 21
                                        ? 'Good Evening!\n$userName'
                                        : 'Good Night!\n$userName',
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
                                File(image!),
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: _buildPosts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                    // FutureBuilder<List<Posts>>(
                    //   future: _postsFuture,
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<List<Posts>> snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Center(
                    //         child: Text('Error: ${snapshot.error}'),
                    //       );
                    //     } else if (snapshot.hasData) {
                    //       final List<Posts>? posts = snapshot.data;
                    //       if (posts!.isEmpty) {
                    //         return NoPosts(widget: widget);
                    //       } else {
                    //         return
                    //          ShowPosts(posts: posts);
                    //       }
                    //     } else {
                    //       return Container(
                    //         color: Colors.red,
                    //         height: 550,
                    //         width: 500,
                    //       );
                    //     }
                    //   },
                    // ),
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
          padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
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
