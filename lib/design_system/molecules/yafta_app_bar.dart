import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yafta/design_system/atoms/yafta_logo.dart';

class YaftaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YaftaAppBar(
      {super.key,
      this.title = "",
      this.back = false,
      this.showBrand = false,
      this.showProfile = true});

  final String title;
  final bool back;
  final bool showBrand;
  final bool showProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != ""
          ? Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            )
          : null,
      scrolledUnderElevation: 0.0,
      leading: Wrap(
        direction: Axis.vertical,
        children: [
          back
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: BackButton(
                    onPressed: () => context.pop(),
                  ),
                )
              : Container(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: showBrand
                ? const YaftaLogo.isologo(
                    width: 90,
                  )
                : const YaftaLogo.isotype(
                    height: 35,
                  ),
          ),
        ],
      ),
      centerTitle: false,
      actions: showProfile
          ? [
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                ),
                onPressed: () {
                  context.push('/profile');
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
