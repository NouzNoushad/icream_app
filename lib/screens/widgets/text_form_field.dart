import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String?)? onSaved;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.controller,
    this.focusNode,
    this.onTapOutside,
    this.onSaved,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onTapOutside: onTapOutside,
        onSaved: onSaved,
        style: GoogleFonts.poppins(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Text(label ?? hintText!),
          hintText: hintText,
          labelStyle: GoogleFonts.poppins(
            fontSize: 15,
          ),
          hintStyle: GoogleFonts.poppins(
            color: Colors.black,
          ),
          fillColor: Colors.white,
          filled: true,
          errorStyle: GoogleFonts.poppins(
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: textInputBorder(),
          focusedBorder: textInputBorder(),
          errorBorder: textInputBorder(),
          focusedErrorBorder: textInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder textInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      );
}
