import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YaftaLogo extends StatelessWidget {
  const YaftaLogo({Key? key, this.height, this.width, required this.name})
      : super(key: key);

  //text and symbol as one
  const YaftaLogo.isologo({Key? key, this.height, this.width})
      : name = 'isologo.svg',
        super(key: key);

  //text and symbol combined
  const YaftaLogo.imagotype({Key? key, this.height, this.width})
      : name = 'imagotype.svg',
        super(key: key);

  //only symbol
  const YaftaLogo.isotype({Key? key, this.height, this.width})
      : name = 'isotype.svg',
        super(key: key);

  final double? height;
  final double? width;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/brand/$name',
      height: height,
      width: width,
    );
  }
}
