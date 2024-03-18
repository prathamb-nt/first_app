import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/widgets/schedule_list_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({
    super.key,
  });

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );

  Future<List<PostFire>> fetchPosts() async {
    late String docId = "docSnapshot.id";

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

  Future<Widget> _buildPosts() async {
    final posts = await fetchPosts();
    if (posts.isEmpty) {
      return NoSchedulePosts(widget: widget);
    } else {
      return ShowSchedulePosts(
          posts: posts, context: context, textstyle: textstyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _buildPosts(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
