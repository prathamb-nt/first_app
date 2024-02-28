import 'package:flutter/material.dart';

import 'create_posts/create_post_screen_step_2.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  late List<ListItem<String>> list;
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    populateData();
  }

  final List<String> imageUrl = [
    'assets/posts/main.png',
    'assets/posts/other1.jpg',
    'assets/posts/other2.jpg',
    'assets/posts/main.png',
  ];
//ListItem<String>(imageUrl[i].toString())
  void populateData() {
    list = [];
    for (int i = 0; i < imageUrl.length ; i++) {
      list.add(ListItem<String>(imageUrl[i].toString()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Selection"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrl.length,
        itemBuilder: _getListItemTile,
      ),
    );
  }
  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(

        onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child:Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            border: selectedIndex == index ?
            Border.all(width: 2,color: Color(0xffED4D86))
                : Border.all(width: 2,color: Colors.transparent)
        ),
        child: Image.asset(
          imageUrl[index],
          fit: BoxFit.fill,
        ),
      )

      // Container(
      //   margin: EdgeInsets.symmetric(vertical: 4),
      //   color: list[index].isSelected ? Colors.red[100] : Colors.white,
      //   child: ListTile(
      //     title: Text(list[index].data),
      //   ),
      // ),
    );
  }
}