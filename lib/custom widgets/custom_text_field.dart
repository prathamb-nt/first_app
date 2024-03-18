import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      required this.obscureText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.montserrat(
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
    return Form(
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusColor: const Color(0xffED4D86),
          contentPadding: const EdgeInsetsDirectional.all(10),
          isDense: true,
          hintText: hintText,
          hintStyle: textStyle,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffED4D86),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;

  const CustomPasswordTextField({
    super.key,
    this.controller,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      obscureText: passwordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIconColor:
            passwordVisible ? Colors.grey : const Color(0xffED4D86),
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        isDense: true,
        contentPadding: const EdgeInsetsDirectional.all(10),
        hintText: 'Enter Your Password',
        hintStyle: textStyle,
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffED4D86),
          ),
        ),
      ),
    );
  }
}
