import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/utils/remote_config.dart';

class MovementRow extends StatelessWidget {
  const MovementRow({Key? key, required this.movement}) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Eliminar Movimiento'),
                content:
                    const Text('¿Seguro que desa eliminar este movimiento?'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Eliminar')),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                ],
              );
            });
      },
      onDismissed: (direction) {
        context
            .read<MovementProvider>()
            .deleteMovement(movement.id!)
            .then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Movimiento eliminado'),
                  duration: Duration(seconds: 1),
                )))
            .catchError((error) =>
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error al eliminar el movimiento'),
                  duration: Duration(seconds: 1),
                )));
      },
      direction: DismissDirection.endToStart,
      key: Key(movement.id.toString()),
      child: ListTile(
        title: Text(movement.description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            )),
        subtitle: RemoteConfigHandler.instance!.getBudgets()
            ? Align(
                alignment: Alignment.topLeft,
                child: Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  shape: const RoundedRectangleBorder(
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
      ),
    );
  }
}
