import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/snackbar.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onIcon,
      required this.offIcon,
      this.doesItWork = true,
      this.defaultValue = false,
      required this.onTap});
  final String title;
  final bool defaultValue;
  final Icon icon;
  final IconData onIcon;
  final IconData offIcon;
  final bool doesItWork;
  final Function onTap;
  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool isSwitched = false;
  double opacity = 0;
  double padding = 25;
  @override
  void initState() {
    super.initState();
    loadAnimations();
    isSwitched = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: EdgeInsets.only(top: padding),
        width: MediaQuery.of(context).size.width,
        height: 85,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(22.5),
          boxShadow: [
            BoxShadow(
                color: kPrimaryColor.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 12.5,
                offset: const Offset(0, 15)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 50),
                    child: isSwitched
                        ? Text(
                            "Enabled",
                            key: const ValueKey('enabled'),
                            style: GoogleFonts.ubuntu(
                                color: Colors.teal.withOpacity(0.9),
                                fontSize: 22.5,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Disabled",
                            key: const ValueKey('disabled'),
                            style: GoogleFonts.ubuntu(
                                color: kSecondaryColor,
                                fontSize: 22.5,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.ubuntu(
                        color: kPrimaryColor.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(22.5),
                  topRight: Radius.circular(22.5)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(height: 150, width: 150, child: widget.icon),
                  Transform.scale(
                    scale: 1.25,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) async {
                        if (value) {
                          if (widget.doesItWork) {
                            bool result = await widget.onTap();
                            if (result) {
                              setState(() {
                                isSwitched = value;
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              ShowSnackBar(context,
                                  backgroundColor:
                                      const Color(0xFF4CAF50).withOpacity(0.9),
                                  content:
                                      "${widget.title.toLowerCase()[0].toUpperCase() + widget.title.toLowerCase().substring(1)} was enabled.");
                            }
                          } else {
                            setState(() {
                              isSwitched = value;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            setState(() {
                              isSwitched = false;
                            });
                            ShowSnackBar(context,
                                backgroundColor:
                                    kSecondaryColor.withOpacity(0.9),
                                success: false,
                                content:
                                    "${widget.title.toLowerCase()[0].toUpperCase() + widget.title.toLowerCase().substring(1)} doesn't work yet.");
                          }
                        } else {
                          widget.onTap();
                        }
                      },
                      thumbIcon: isSwitched
                          ? WidgetStatePropertyAll(Icon(
                              widget.onIcon,
                              color: Colors.lightGreenAccent,
                            ))
                          : WidgetStatePropertyAll(Icon(
                              widget.offIcon,
                              color: kSecondaryColor,
                            )),
                      dragStartBehavior: DragStartBehavior.start,
                      inactiveTrackColor: kSecondaryColor,
                      inactiveThumbColor: Colors.white,
                      trackOutlineColor: WidgetStatePropertyAll(
                          kPrimaryColor.withOpacity(0.25)),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity = 1;
      padding = 0;
    });
  }
}
