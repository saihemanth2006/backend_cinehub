import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../core/extensions/string_extensions.dart';

/// Avatar with gradient fallback, online indicator, and initials.
class CachedAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final bool showOnlineIndicator;
  final bool isOnline;

  const CachedAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = 44,
    this.showOnlineIndicator = false,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: imageUrl == null ? AppGradients.primary : null,
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
              border: Border.all(
                color: AppColors.border,
                width: 1.5,
              ),
            ),
            child: imageUrl == null
                ? Center(
                    child: Text(
                      name.initials,
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                        fontSize: size * 0.35,
                      ),
                    ),
                  )
                : null,
          ),
          if (showOnlineIndicator)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? AppColors.online : AppColors.offline,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
