import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Image carousel widget with pagination dots
class ImageCarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final List<Widget>? overlayWidgets;

  const ImageCarouselWidget({
    Key? key,
    required this.imageUrls,
    this.height = 300,
    this.overlayWidgets,
  }) : super(key: key);

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        color: AppColors.backgroundGrey,
        child: const Center(
          child: Icon(Icons.image, size: 60, color: AppColors.iconSecondary),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryPurple,
                      AppColors.primaryPurpleLight,
                      AppColors.accentBlue,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: AppColors.iconWhite.withOpacity(0.5),
                  ),
                ),
              );
            },
          ),
          // Overlay widgets (e.g., bookmark, share icons)
          if (widget.overlayWidgets != null) ...widget.overlayWidgets!,
          // Pagination dots
          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageUrls.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? AppColors.primaryPurple
                          : AppColors.backgroundWhite.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
