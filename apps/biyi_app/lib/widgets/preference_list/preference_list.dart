import 'package:flutter/material.dart';

export './preference_list_item.dart';
export './preference_list_section.dart';

class PreferenceList extends StatelessWidget {
  const PreferenceList({
    super.key,
    this.padding,
    required this.children,
  });

  final EdgeInsets? padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding ??
          const EdgeInsets.only(
            top: 12,
            bottom: 12,
          ),
      children: children,
    );
  }
}
