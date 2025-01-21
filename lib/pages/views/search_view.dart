import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siwalima_ios/config/app_colors.dart';
import '../../config/app_assets.dart';
import '../../config/nav.dart';
import '../../config/wp_api.dart';
import '../news_detail_page.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final edtSearchText = TextEditingController();
  Future<List>? _mysearchnews;

  void search() {
    setState(() {
      _mysearchnews = WpApi.fecthWpNewsListSearch(edtSearchText.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: header(),
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1.0,
        titleSpacing: 0,
        leadingWidth: 0,
        leading: Container(),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _mysearchnews,
          builder: (context, snapshot) {
            String txt = edtSearchText.text;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return DView.loadingCircle();
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('Data tidak ditemukan.'),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pencarian untuk "$txt"',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map wpcategorylistnews = snapshot.data![index];
                          String wpjudul = wpcategorylistnews['title']
                                  ['rendered']
                              .replaceAll("&#038;", "&")
                              .replaceAll("&#8211;", "-");
                          DateTime utcTime =
                              DateTime.parse(wpcategorylistnews['date']);
                          DateTime localTime =
                              utcTime.add(const Duration(hours: 9));
                          String waktupost =
                              DateFormat('dd MMMM yyyy').format(localTime);

                          return GestureDetector(
                            onTap: () {
                              Nav.push(
                                context,
                                NewsDetailPage(
                                  judul: wpjudul,
                                  tanggal: waktupost.toString(),
                                  gambar: wpcategorylistnews['yoast_head_json']
                                      ['og_image'][0]['url'],
                                  kategori: wpcategorylistnews['categories'][0],
                                  isi: wpcategorylistnews['content']
                                      ['rendered'],
                                  link: wpcategorylistnews['link'],
                                  id: wpcategorylistnews['id'],
                                ),
                              );
                            },
                            child: categorylistnews(
                                wpcategorylistnews, wpjudul, waktupost),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text("");
          },
        ),
      ),
    );
  }

  Row searchbar() {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            height: 50,
            child: TextField(
              controller: edtSearchText,
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                search();
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Padding categorylistnews(Map<dynamic, dynamic> wpcategorylistnews,
      String wpjudul, String waktupost) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: wpcategorylistnews['yoast_head_json']
                                ['og_image'][0]['url'],
                            placeholder: (context, url) =>
                                DView.loadingCircle(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeOutDuration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: AspectRatio(
                      aspectRatio: 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wpjudul,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DView.spaceHeight(4),
                          Text(
                            waktupost.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(                   
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /* IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ), */
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 200,
                child: Image.asset(
                  AppAssets.logoHeader,
                ),
              ),
            ),
          ],
        ),
        searchbar(),
      ],
    );
  }
}
