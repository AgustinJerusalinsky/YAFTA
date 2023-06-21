import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';
import 'package:yafta/services/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void onChangePassword(BuildContext context, AuthProvider authProvider) async {
    await authProvider.changePassword();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green.shade300,
        content: Text("Se ha enviado un correo para modificar la contraseña")));
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
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 83.5,
                    backgroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/26574372?v=4"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 45),
                    child: Wrap(
                      runSpacing: 24,
                      children: [
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
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          textStyle:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
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
        );
      },
    );
  }
}
