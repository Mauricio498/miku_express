import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: const Color(0xFFB8F0E5),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: selected ? const Color(0xFF168A78) : Colors.black12,
        ),
        labelStyle: TextStyle(
          color: selected ? const Color(0xFF12695C) : const Color(0xFF45465A),
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
        showCheckmark: false,
      ),
    );
  }
}
