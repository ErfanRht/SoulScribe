import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:soulscribe/constants/colors.dart';

class ActivityPageEntriesError extends StatefulWidget {
  const ActivityPageEntriesError({super.key});

  @override
  State<ActivityPageEntriesError> createState() =>
      _ActivityPageEntriesErrorState();
}

class _ActivityPageEntriesErrorState extends State<ActivityPageEntriesError> {
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: UnDraw(
            height: 200,
            color: kSecondaryColor,
            illustration: UnDrawIllustration.web_search,
            placeholder: const Padding(
              padding: EdgeInsets.only(top: 50),
              child: SpinKitDoubleBounce(
                color: kSecondaryColor,
                size: 75,
              ),
            ),
            errorWidget:
                const Icon(Icons.error_outline, color: Colors.red, size: 50),
          ),
        ));
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    setState(() {
      opacity = 1;
    });
  }
}
