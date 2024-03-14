import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/edit_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    fetchPosts();
  }

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );
  late int currentUserId = int.parse(widget.currentUser);

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
      return NoSchedulePosts(widget: widget);
    } else {
      return Column(
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
            children: posts.map((post) {
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
                    elevation: 12,
                    color: const Color(0xffFFFFFC),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                            padding: const EdgeInsets.only(left: 10.0),
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
              );
            }).toList(),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: _buildPosts(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return snapshot.data!;
              }
            },
          ),
          // FutureBuilder<List<Posts>>(
          //   future: _postsFuture,
          //   builder:
          //       (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       return Center(
          //         child: Text('Error: ${snapshot.error}'),
          //       );
          //     } else if (snapshot.hasData) {
          //       final List<Posts>? posts = snapshot.data;
          //       if (posts!.isEmpty) {
          //         return NoSchedulePosts(widget: widget);
          //       } else {
          //         return ShowSchedulePosts(
          //           posts: posts,
          //           displayImage: widget.displayImage,
          //           imageText: widget.imageText,
          //           currentUser: widget.currentUser,
          //         );
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

class ShowSchedulePosts extends StatefulWidget {
  final String displayImage;
  final String imageText;
  final String currentUser;

  const ShowSchedulePosts({
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.posts!.map<Widget>(
            (Posts post) {
              return ListTile(
                title: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditPost(
                    //       currentUser: widget.currentUser,
                    //       postTime: post.postTime,
                    //       displayImage: post.post,
                    //       postDate: post.postDate,
                    //       postPlatform: post.postPlatform,
                    //       postId: post.postId,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Card(
                    elevation: 12,
                    color: const Color(0xffFFFFFC),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                                child: Image.memory(
                                  post.post,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
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
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
