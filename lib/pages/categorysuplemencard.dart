// lib/category_card.dart
import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../model/listkategorisuplemen.dart';
import '../pages/views/kategori_list_berita.dart';

import '../config/nav.dart';

class CategorySuplemenCard extends StatelessWidget {
  final ListKategorySuplemen category;

  const CategorySuplemenCard({Key? key, required this.category}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/${category.icon}", width: 36, height: 36,),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
