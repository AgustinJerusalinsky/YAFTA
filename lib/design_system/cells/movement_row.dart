import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/utils/remote_config.dart';

class MovementRow extends StatelessWidget {
  const MovementRow({Key? key, required this.movement}) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movement.description,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          )),
      subtitle: RemoteConfigHandler.getBudgets()
          ? Align(
              alignment: Alignment.topLeft,
              child: Chip(
                padding: EdgeInsets.symmetric(horizontal: 8),
                label: Text(movement.category.name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer)),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 1),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ))
          : null,
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(
                '${movement.type == MovementType.income ? "+" : "-"}\$${movement.amount}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface)),
            Text(DateFormat('dd/MM/yyyy').format(movement.date!),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
