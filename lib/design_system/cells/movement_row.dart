import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

class MovementRow extends StatelessWidget {
  const MovementRow({Key? key, required this.movement}) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("movement.description"),
      subtitle: Align(
          alignment: Alignment.topLeft,
          child: Chip(
            padding: EdgeInsets.symmetric(horizontal: 8),
            label: Text(movement.category.name,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            side: BorderSide(
                color: Theme.of(context).colorScheme.secondaryContainer,
                width: 1),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          )),
      trailing: Column(
        children: [
          Text(
              '${movement.type == MovementType.income ? "+" : "-"}\$${movement.amount}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(DateFormat('dd/MM/yyyy').format(movement.date!),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
