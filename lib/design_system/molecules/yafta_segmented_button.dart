import 'package:flutter/material.dart';

enum Calendar { daily, monthly, allTime }

const segments = [
  {"value": 0, "label": "Hoy"},
  {
    "value": 1,
    "label": "Este mes",
  },
  {
    "value": 2,
    "label": "Total",
  }
];

class YaftaSegmentedButton extends StatefulWidget {
  const YaftaSegmentedButton({Key? key, required this.onSelectionChanged})
      : super(key: key);
  final void Function(Set<int>) onSelectionChanged;
  @override
  State<YaftaSegmentedButton> createState() => _YaftaSegmentedButtonState();
}

class _YaftaSegmentedButtonState extends State<YaftaSegmentedButton> {
  int _currentSegment = 0;

  void onSelectionChanged(Set<int> selected) {
    setState(() {
      _currentSegment = selected.first;
    });
    widget.onSelectionChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SegmentedButton<int>(
            segments: segments
                .map((segment) => ButtonSegment(
                      value: segment["value"] as int,
                      label: Text(segment["label"] as String,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                    ))
                .toList(),
            selected: <int>{_currentSegment},
            onSelectionChanged: onSelectionChanged,
          ),
        )
      ],
    );
  }
}
