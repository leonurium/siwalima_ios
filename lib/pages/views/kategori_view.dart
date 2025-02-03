import 'package:flutter/material.dart';
import 'package:siwalima_ios/model/listkategorisuplemen.dart';
import 'package:siwalima_ios/pages/categorysuplemencard.dart';
//import 'package:siwalima_ios/pages/views/search_view.dart';
import '../../config/app_assets.dart';
//import '../../config/nav.dart';
import '../../config/app_colors.dart';
import '../../config/nav.dart';
import '../../model/listkategori.dart';
import '../categorycard.dart';
import '../redaksi_page.dart';

class KategoriView extends StatefulWidget {
  const KategoriView({super.key});

  @override
  State<KategoriView> createState() => _KategoriViewState();
}

class _KategoriViewState extends State<KategoriView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: header(),
        backgroundColor: Colors.white,
        elevation: 1.0,
        foregroundColor: Colors.black,
        titleSpacing: 0,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Kategori Berita",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 3 columns
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(category: categories[index]);
                    },
                  ),
                ),
                divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Suplemen",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,16,8,8),
                  child: SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categoriessuplemen.length,
                      itemBuilder: (context, index) {
                        return CategorySuplemenCard(
                            category: categoriessuplemen[index]);
                      },
                    ),
                  ),
                ),
                divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Redaksi",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 8, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Nav.push(context, const RedaksiPage());
                        },
                        child: Icon(
                          Icons.people_rounded,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Nav.push(context, const RedaksiPage());
                        },
                        child: Text(
                          "Tim & Kontak",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Divider divider() {
    return Divider(
      indent: 0,
      endIndent: 0,
      color: Colors.grey.shade100,
      height: 0,
      thickness: 2,
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            child: Image.asset(
              AppAssets.logoHeader,
            ),
          ),
        ),
        /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Nav.push(
                context,
                const SearchView(),
              );
            },
            child: const Icon(
              Icons.search_outlined,
              size: 26,
              color: Colors.black,
            ),
          ),
        ) */
      ],
    );
  }
}
