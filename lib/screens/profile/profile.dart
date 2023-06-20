import 'package:flutter/material.dart';
import 'package:yafta/design_system/molecules/button.dart';
import 'package:yafta/design_system/molecules/text_field.dart';
import 'package:yafta/design_system/molecules/yafta_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YaftaAppBar(
        back: true,
        showBrand: true,
        showProfile: false,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Column(
          children: [
            CircleAvatar(
              radius: 83.5,
              backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/26574372?v=4"),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 45),
                child: Wrap(
                  runSpacing: 24,
                  children: [
                    YaftaTextField(
                      label: "Nombre completo",
                      readOnly: true,
                      initialValue: "El beto",
                    ),
                    YaftaTextField(
                      label: "Email",
                      readOnly: true,
                      initialValue: "beto@mail.com",
                    ),
                    YaftaTextField(
                      label: "Usuario",
                      readOnly: true,
                      initialValue: "ElBeto",
                    ),
                    YaftaButton(
                      text: "Cambiar contraseña",
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      textStyle:
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                    ),
                    YaftaButton(
                      text: "Cerrar sesión",
                      textStyle:
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      variant: "outlined",
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
