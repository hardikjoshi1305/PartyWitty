import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event_detail.dart';

/// Menu section widget displaying menu categories and items
/// Matches Figma design with two columns and interspersed food images
class MenuSectionWidget extends StatelessWidget {
  final List<MenuCategory> menuCategories;

  const MenuSectionWidget({Key? key, required this.menuCategories})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (menuCategories.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Container(
          margin: const EdgeInsets.only(bottom: 12,top: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(bottom: 13,top: 8,left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Menu', style: AppTextStyles.heading4),
      ...menuCategories.map((category) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        width:150,
      height: 200,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
      color: AppColors.backgroundGrey,
      borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
      child: Image.asset('assets/images/menu.png',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,),
      ),
      ),
      SizedBox(width: 14,),
      Container(
        width:150,
      height: 200,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
      color: AppColors.backgroundGrey,
      borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
      child: Image.asset('assets/images/menu.png',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,),
      ),
      ),
      // Category name
      // Menu items in two columns with images interspersed

      const SizedBox(height: 4),
      ],
      ),
    );
    }),
    ],
    )
        ),
        // Menu categories

      ],
    );
  }


}
