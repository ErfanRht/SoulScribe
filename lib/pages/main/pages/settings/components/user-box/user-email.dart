import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/user/user.dart';
import 'package:soulscribe/widgets/snackbar.dart';

class UserBoxUserEmail extends StatefulWidget {
  const UserBoxUserEmail({super.key});

  @override
  _UserBoxUserEmailState createState() => _UserBoxUserEmailState();
}

class _UserBoxUserEmailState extends State<UserBoxUserEmail> {
  bool _isEditing = false;
  final TextEditingController _controller =
      TextEditingController(text: Get.find<MainController>().userEmail);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _isEditing = true;
          });
        },
        child: _isEditing
            ? TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                autofocus: true,
                cursorColor: kSecondaryColor,
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 20),
                onSubmitted: (newValue) async {
                  onEmailModified(context, newValue: newValue);
                },
                onEditingComplete: () {
                  onEmailModified(context, newValue: _controller.text);
                },
                onTapOutside: (event) {
                  onEmailModified(context, newValue: _controller.text);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            : Text(
                _.userEmail != "" ? _.userEmail : "YourEmail@Gmail.com",
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 20.5),
              ),
      );
    });
  }

  onEmailModified(BuildContext context,
      {required final String newValue}) async {
    bool result = await UpdateUserData(email: newValue);
    setState(() {
      _isEditing = false;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (result) {
      ShowSnackBar(context,
          backgroundColor: const Color(0xFF4CAF50).withOpacity(0.9),
          content: "Your email was successfully modified.");
    } else {
      ShowSnackBar(context,
          success: false,
          backgroundColor: kSecondaryColor.withOpacity(0.9),
          content: "Your email format wasn't correct.");
    }
  }
}
