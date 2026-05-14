import 'package:flutter/material.dart';

class CategoryDelegate extends SliverPersistentHeaderDelegate {
  final String selected;
  final ValueChanged<String> onChange;

  const CategoryDelegate({required this.selected, required this.onChange});

  static const double _h = 60.0;

  @override
  double get maxExtent => _h;

  @override
  double get minExtent => _h;

  @override
  bool shouldRebuild(covariant CategoryDelegate old) => selected != old.selected;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xff09090B),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: ["All", "Crew", "Cast", "Collaborative", "Saved"].map((cat) {
          final active = selected == cat;
          return GestureDetector(
            onTap: () => onChange(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: active
                    ? const LinearGradient(
                        colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                      )
                    : null,
                color: active ? null : Colors.white.withOpacity(0.07),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cat == "Saved") ...[
                    Icon(
                      Icons.bookmark_rounded,
                      size: 12,
                      color: active ? Colors.white : Colors.white.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    cat,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: active ? Colors.white : Colors.white.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
