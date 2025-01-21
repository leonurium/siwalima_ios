// lib/category_card.dart
import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../model/listkategori.dart';
import '../pages/views/kategori_list_berita.dart';

import '../config/nav.dart';

class CategoryCard extends StatelessWidget {
  final ListKategory category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.push(
          context,
          KategoriListBerita(idkategori: category.idkategori, namakategori: category.name),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category.icon,
            size: 32,
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          Text(
            category.name,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
