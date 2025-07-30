import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class ImageMessage extends StatelessWidget {
  final String url;
  final bool isUserMessage;
  const ImageMessage({
    super.key,
    required this.url,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutePaths.IMAGE_VIEWER, arguments: url);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: CustomSpacing.xxs,
          right: isUserMessage ? 0 : CustomSpacing.lg,
          left: isUserMessage ? CustomSpacing.lg : 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),

          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                margin: EdgeInsets.only(
                  top: CustomSpacing.xxs,
                  right: isUserMessage ? 0 : CustomSpacing.lg,
                  left: isUserMessage ? CustomSpacing.lg : 0,
                ),
                padding: CustomSpacing.squishXS,
                decoration: BoxDecoration(
                  color:
                      isUserMessage
                          ? CustomColors.primary
                          : CustomColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      isUserMessage
                          ? CustomBorders.radiusNone
                          : CustomBorders.radiusMD,
                    ),
                    bottomLeft: Radius.circular(
                      isUserMessage
                          ? CustomBorders.radiusMD
                          : CustomBorders.radiusNone,
                    ),
                    topLeft: Radius.circular(CustomBorders.radiusMD),
                    topRight: Radius.circular(CustomBorders.radiusMD),
                  ),
                  boxShadow: [CustomShadow.shadow],
                ),

                child: Icon(
                  Icons.broken_image,
                  size: 48,
                  color: CustomColors.primary,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: CustomSpacing.xl,
                height: CustomSpacing.xl,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
