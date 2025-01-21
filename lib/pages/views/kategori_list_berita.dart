import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siwalima_ios/config/app_colors.dart';
//import 'package:siwalima_ios/pages/views/search_view.dart';
import '../../config/app_assets.dart';
import '../../config/nav.dart';
import '../../config/wp_api.dart';
import '../news_detail_page.dart';

class KategoriListBerita extends StatefulWidget {
  const KategoriListBerita(
      {super.key, required this.idkategori, required this.namakategori});
  final int idkategori;
  final String namakategori;

  @override
  State<KategoriListBerita> createState() => _KategoriListBeritaState();
}

class _KategoriListBeritaState extends State<KategoriListBerita> {
  Future<List>? _mycategorynews;

  @override
  void initState() {
    _mycategorynews = WpApi.fecthWpNewsListKategori(widget.idkategori);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: header(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1.0,
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: _mycategorynews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DView.loadingCircle();
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.namakategori,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map wpcategorylistnews = snapshot.data![index];
                        String wpjudul = wpcategorylistnews['title']['rendered']
                            .replaceAll("&#038;", "&")
                            .replaceAll("&#8211;", "-");
                        DateTime utcTime =
                            DateTime.parse(wpcategorylistnews['date']);
                        String waktupost =
                            DateFormat('dd MMMM yyyy').format(utcTime);

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
                                isi: wpcategorylistnews['content']['rendered'],
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
                              fontSize: 16,
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

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Image.asset(
            AppAssets.logoHeader,
          ),
        ),
        /* Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
        ), */
      ],
    );
  }
}
