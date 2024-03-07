// class CreatePostScreenStep3 extends StatefulWidget {
//   final String displayImage;
//   final String currentUser;

//   const CreatePostScreenStep3({
//     super.key,
//     required this.displayImage,
//     required this.currentUser,
//   });

//   @override
//   _CreatePostScreenStep3State createState() => _CreatePostScreenStep3State();
// }

// class _CreatePostScreenStep3State extends State<CreatePostScreenStep3> {
//   late String textValue;
//   late String imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     textValue = '';
//     imageUrl = widget.displayImage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
//           child: Column(
//             children: [
//               // ...
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: SizedBox(
//                   height: 120,
//                   width: 342,
//                   child: TextFormField(
//                     onTapOutside: (event) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     onChanged: (text) {
//                       setState(() {
//                         textValue = text;
//                       });
//                     },
//                     minLines: 5,
//                     maxLines: 5,
//                     style: textstyle,
//                     controller: _textController,
//                     decoration: const InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xffED4D86),
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color(0xffED4D86),
//                           width: 1.0,
//                         ),
//                       ),
//                       alignLabelWithHint: false,
//                       contentPadding: EdgeInsetsDirectional.all(10),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ),
//               // ...
//               buildPostImage(),
//               // ...
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 child: GestureDetector(
//                   onTap: () async {
//                     saveDataToDatabase();
//                     // Navigate to CreatePostScreenStep4 or perform other actions
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 342,
//                     decoration: const BoxDecoration(
//                       color: Color(0xffED4D86),
//                       borderRadius: BorderRadius.all(Radius.circular(6)),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Next',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Color(0xffFFFFFC),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void saveDataToDatabase() async {
//     final data = {
//       'user_id': widget.currentUser,
//       'image_url': imageUrl,
//       'caption': textValue,
//     };

//     final id = await DatabaseHelper().insert(data);
//     print('Inserted row id: $id');

//     // Clear the TextEditingController after saving the data
//     _textController.clear();

//     // Reset the textValue and imageUrl
//     setState(() {
//       text