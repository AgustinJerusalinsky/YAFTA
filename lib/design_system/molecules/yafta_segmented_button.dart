import 'package:flutter/material.dart';

import '../../models/segment.dart';

enum Calendar { daily, monthly, allTime }

class YaftaSegmentedButton extends StatefulWidget {
  const YaftaSegmentedButton(
      {Key? key, required this.onSelectionChanged, required this.segments})
      : super(key: key);
  final void Function(int) onSelectionChanged;
  final List<Segment> segments;
  @override
  State<YaftaSegmentedButton> createState() => _YaftaSegmentedButtonState();
}

class _YaftaSegmentedButtonState extends State<YaftaSegmentedButton> {
  int _currentSegment = 0;

  void onSelectionChanged(Set<int> selected) {
    setState(() {
      _currentSegment = selected.first;
      widget.onSelectionChanged(selected.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SegmentedButton<int>(
            segments: widget.segments
                .map((segment) => ButtonSegment(
                      value: segment.value,
                      label: Text(segment.label,
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
