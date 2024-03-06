import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/widgets/bottom_navbar.dart';
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
    _postsFuture = DatabaseHelper().getPosts();
  }

  late int currentUserId = int.parse(widget.currentUser);

  @override
  Widget build(BuildContext context) {
    return buildPosts();
  }

  FutureBuilder<List<Posts>> buildPosts() {
    return FutureBuilder<List<Posts>>(
      future: _postsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Posts>? posts = snapshot.data;
          return ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (BuildContext context, int index) {
              final Posts post = posts![index];
              return Card(
                child: ListTile(
                  title: Column(
                    children: [
                      Image.memory(post.post),
                      Text(post.postDate),
                      Text("${post.postId}"),
                      Text(post.postTime),
                    ],
                  ),
                  subtitle: Text("${post.userId}"),
                ),
              );
            },
          );
        } else {
          return buildNoPosts(context);
        }
      },
    );
  }

  Column buildNoPosts(BuildContext context) {
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
