import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/design_system/molecules/yafta_overlay_loading.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:yafta/utils/analytics.dart';
import 'package:yafta/utils/remote_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _submitting = false;

  void onChangePassword(BuildContext context, AuthProvider authProvider) async {
    await authProvider.changePassword();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green.shade300,
        content: const Text(
            "Se ha enviado un correo para modificar la contraseña")));
  }

  void _handleToggleChange(bool value) async {
    setState(() {
      _submitting = true;
    });
    await context
        .read<AuthProvider>()
        .toggleTheme(value ? AppTheme.dark : AppTheme.light);
    if (value) {
      await AnalyticsHandler.logThemeToggle();
    }
    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          appBar: const YaftaAppBar(
            back: true,
            showBrand: true,
            showProfile: false,
          ),
          body: YaftaOverlayLoading(
            isLoading: _submitting,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/26574372?v=4"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 45),
                      child: Wrap(
                        runSpacing: 24,
                        children: [
                          if (RemoteConfigHandler.getAppThemeToggle()) ...[
                            Column(
                              children: [
                                const Text("Dark theme"),
                                Switch(
                                    // This bool value toggles the switch.
                                    value: context
                                                .watch<AuthProvider>()
                                                .user
                                                ?.theme ==
                                            AppTheme.light
                                        ? false
                                        : true,
                                    onChanged: _handleToggleChange),
                              ],
                            ),
                          ],
                          YaftaTextField(
                            label: "Nombre completo",
                            readOnly: true,
                            initialValue: authProvider.user?.fullName ?? "",
                          ),
                          YaftaTextField(
                            label: "Email",
                            readOnly: true,
                            initialValue: authProvider.user?.email ?? "",
                          ),
                          YaftaTextField(
                            label: "Usuario",
                            readOnly: true,
                            initialValue: authProvider.user?.userName ?? "",
                          ),
                          YaftaButton(
                            text: "Cambiar contraseña",
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                ),
                            onPressed: () =>
                                onChangePassword(context, authProvider),
                          ),
                          YaftaButton(
                            text: "Cerrar sesión",
                            onPressed: () {
                              authProvider.logout();
                            },
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            variant: "outlined",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
