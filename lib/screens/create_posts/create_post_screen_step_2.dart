import 'package:all_social_app/screens/create_posts/create_post_screen_step_3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreatePostScreenStep2 extends StatefulWidget {
  const CreatePostScreenStep2({super.key});

  @override
  State<CreatePostScreenStep2> createState() => _CreatePostScreenStep2State();
}

class _CreatePostScreenStep2State extends State<CreatePostScreenStep2> {
  int selectedIndex = 0;

  late List<ListItem<String>> list;
  @override
  void initState() {
    super.initState();
    populateData();
  }

  final List<String> imageUrl = [
    'assets/posts/main.png',
    'assets/posts/other1.jpg',
    'assets/posts/other2.jpg',
    'assets/posts/other3.jpg',
  ];
  void populateData() {
    list = [];
    for (int i = 0; i < imageUrl.length; i++) {
      list.add(ListItem<String>(imageUrl[i].toString()));
    }
  }

  String displayImageUrl = "assets/posts/main.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0.25,
                end: 0.50,
              ),
              builder: (context, value, _) => LinearPercentIndicator(
                animation: true,
                animationDuration: 300,
                animateFromLastPercent: true,
                width: 342.0,
                lineHeight: 8.0,
                percent: 0.50,
                barRadius: const Radius.circular(20),
                progressColor: const Color(0xffED4D86),
                backgroundColor: const Color(0xffE6E6E6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Step 2',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff1C1C1C)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Select your post background image.',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff1C1C1C)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 342,
              width: 342,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 342,
                      width: 342,
                      child: Image.asset(displayImageUrl),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 42, 0, 55),
              child: Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrl.length,
                    itemBuilder: _getListItemTile,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePostScreenStep3(),
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
                    child: Text('Next',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xffFFFFFC)),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          displayImageUrl = imageUrl[index].toString();
          print(imageUrl[index].toString());
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: selectedIndex == index
                  ? Border.all(width: 2, color: const Color(0xffED4D86))
                  : Border.all(width: 2, color: Colors.transparent)),
          child: Image.asset(
            imageUrl[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class ListItem<T> {
  int? selectedIndex; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}
