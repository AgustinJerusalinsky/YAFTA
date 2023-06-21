import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/atoms/yafta_logo.dart';
import 'package:yafta/services/auth_provider.dart';

import '../../utils/remote_config.dart';

class YaftaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YaftaAppBar(
      {super.key,
      this.title = "",
      this.back = false,
      this.showBrand = false,
      this.showProfile = true,
      this.showThemeSwitch = false,
      this.useDarkTheme = false,
      this.onThemeSwitchChange});

  final String title;
  final bool back;
  final bool showBrand;
  final bool showProfile;
  final bool showThemeSwitch;
  final bool useDarkTheme;
  final Function(bool)? onThemeSwitchChange;

  void onThemeSwitch(bool value) {
    if (onThemeSwitchChange != null) {
      onThemeSwitchChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != ""
          ? Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          : null,
      scrolledUnderElevation: 0.0,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
                ? Consumer<AuthProvider>(
                    builder: (ctx, provider, _) {
                      return const YaftaLogo.isologo(
                        width: 90,
                      );
                    },
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
          : showThemeSwitch && RemoteConfigHandler.getAppThemeToggle()
              ? [
                  Switch(
                    value: useDarkTheme,
                    onChanged: onThemeSwitch,
                    activeColor: Theme.of(context).colorScheme.secondary,
                  )
                ]
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
