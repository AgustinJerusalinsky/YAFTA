import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yafta/services/auth_provider.dart';

import '../../utils/remote_config.dart';

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
    return Consumer<AuthProvider>(
      builder: (ctx, provider, _) {
        return SvgPicture.asset(
          'assets/brand/$name',
          height: height,
          width: width,
          theme: SvgTheme(
              currentColor: provider.theme == AppTheme.light
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFFBFC8CA)),
        );
      },
    );
  }
}
