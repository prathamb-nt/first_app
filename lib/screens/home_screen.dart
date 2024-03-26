import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/widgets/bottom_navbar.dart';
import 'package:all_social_app/widgets/no_posts.dart';
import 'package:all_social_app/widgets/show_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final String? currentDocId;
  const HomeScreen({super.key, this.currentDocId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      body: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Users? users;
  late String name;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );
  int hours = DateTime.now().hour;

  late String docId = "docSnapshot.id";

  Future readUser() async {
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
    );

    final docUser = FirebaseFirestore.instance.collection('users').doc(docId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserFire.fromJson(snapshot.data()!);
    }
  }

  Future<Widget> _buildPosts() async {
    final posts = await fetchPosts();
    if (posts.isEmpty) {
      return NoPosts(widget: widget);
    } else {
      return ShowPosts(posts: posts, textstyle: textstyle);
    }
  }

  Future<List<PostFire>> fetchPosts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection('posts')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return PostFire.fromJson(data);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: readUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('');
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final userName = snapshot.data?.userName;
            final image = snapshot.data?.profileImage;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 40.h),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                              child:
                                  // Image.network(
                                  //   image!,
                                  //   frameBuilder: (context, child, frame,
                                  //       wasSynchronouslyLoaded) {
                                  //     return child;
                                  //   },
                                  //   loadingBuilder:
                                  //       (context, child, loadingProgress) {
                                  //     if (loadingProgress == null) {
                                  //       return child;
                                  //     } else {
                                  //       return Shimmer.fromColors(
                                  //         baseColor: Colors.grey,
                                  //         highlightColor: Colors.white30,
                                  //         child: Container(
                                  //           height: 46,
                                  //           width: 46,
                                  //           decoration: const BoxDecoration(
                                  //             shape: BoxShape.circle,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }
                                  //   },
                                  // )
                                  Image.network(
                                image!,
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: _buildPosts(),
                    builder:
                        (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return snapshot.data!;
                      }
                    },
                  ),
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
    );
  }
}
