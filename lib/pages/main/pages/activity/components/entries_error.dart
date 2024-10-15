import 'package:flutter/material.dart';
import 'package:soulscribe/widgets/illustration_loader.dart';

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
          child: const IllustrationLoader(
              address: 'assets/illustrations/undraw_web_search_re_efla.svg'),
        ));
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    setState(() {
      opacity = 1;
    });
  }
}
