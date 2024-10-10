import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/user/user.dart';
import 'package:soulscribe/widgets/snackbar.dart';

class UserBoxUserName extends StatefulWidget {
  const UserBoxUserName({super.key});

  @override
  _UserBoxUserNameState createState() => _UserBoxUserNameState();
}

class _UserBoxUserNameState extends State<UserBoxUserName> {
  bool _isEditing = false;
  final TextEditingController _controller =
      TextEditingController(text: Get.find<MainController>().userName);

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
                  onNameModified(context, newValue: newValue);
                },
                onEditingComplete: () {
                  onNameModified(context, newValue: _controller.text);
                },
                onTapOutside: (event) {
                  onNameModified(context, newValue: _controller.text);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(top: 8.75, bottom: 10, right: 1.5),
                child: Text(
                  _.userName,
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 20.25),
                ),
              ),
      );
    });
  }

  onNameModified(BuildContext context, {required final String newValue}) async {
    UpdateUserData(name: newValue);
    setState(() {
      _isEditing = false;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    ShowSnackBar(context,
        backgroundColor: const Color(0xFF4CAF50).withOpacity(0.9),
        content: "Your name was successfully modified.");
  }
}
