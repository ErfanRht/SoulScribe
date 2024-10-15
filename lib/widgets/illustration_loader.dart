import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IllustrationLoader extends StatelessWidget {
  const IllustrationLoader({super.key, required this.address});
  final String address;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      address,
      placeholderBuilder: (BuildContext context) =>
          const CircularProgressIndicator(),
      height: 200,
      width: 200,
    );
  }
}
