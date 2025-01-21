import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import '../config/app_assets.dart';
import '../config/app_colors.dart';
import '../config/nav.dart';
import '../config/wp_api.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({
    super.key,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.gambar,
    required this.isi,
    required this.link,
    required this.id,
  });
  final String judul, tanggal, gambar, isi, link;
  final int kategori, id;

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
      body: Stack(
        children: [
          ListView(
            children: [
              headerimage(context, gambar),
              judulberita(judul, tanggal),
              divider(),
              isiberita(),
              divider(),
              rekomendasi(context),
            ],
          ),
          //commentButton(context),
        ],
      ),
    );
  }

  Positioned commentButton(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton.extended(
          heroTag: 'comment-button',
          onPressed: () {}, //=> dialogClaim(context),
          label: const Icon(
            Icons.comment_outlined,
            size: 28,
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Padding rekomendasi(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Rekomendasi Untuk Anda',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          DView.spaceHeight(8),
          FutureBuilder(
            future: WpApi.fecthWpNewsRekomendasi(kategori),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DView.loadingCircle();
              }
              if (snapshot.hasData) {
                var wprekomendasi0 = snapshot.data![0]['title']['rendered']
                    .replaceAll("&#038;", "&")
                    .replaceAll("&#8211;", "-");
                var wprekomendasi1 = snapshot.data![1]['title']['rendered']
                    .replaceAll("&#038;", "&")
                    .replaceAll("&#8211;", "-");
                var wprekomendasi2 = snapshot.data![2]['title']['rendered']
                    .replaceAll("&#038;", "&")
                    .replaceAll("&#8211;", "-");
                var wprekomendasi3 = snapshot.data![3]['title']['rendered']
                    .replaceAll("&#038;", "&")
                    .replaceAll("&#8211;", "-");

                String wplink0 = snapshot.data![0]['link'];
                String wplink1 = snapshot.data![1]['link'];
                String wplink2 = snapshot.data![2]['link'];
                String wplink3 = snapshot.data![3]['link'];

                DateTime utcTime0 = DateTime.parse(snapshot.data![0]['date']);
                DateTime localTime0 = utcTime0.add(const Duration(hours: 9));
                String waktupost0 =
                    DateFormat('dd MMMM yyyy').format(localTime0);
                String wpcontent0 = snapshot.data![0]['content']['rendered'];
                wpcontent0 = wpcontent0.replaceAll('data-src', 'src');

                DateTime utcTime1 = DateTime.parse(snapshot.data![1]['date']);
                DateTime localTime1 = utcTime1.add(const Duration(hours: 9));
                String waktupost1 =
                    DateFormat('dd MMMM yyyy').format(localTime1);
                String wpcontent1 = snapshot.data![1]['content']['rendered'];
                wpcontent1 = wpcontent1.replaceAll('data-src', 'src');

                DateTime utcTime2 = DateTime.parse(snapshot.data![2]['date']);
                DateTime localTime2 = utcTime2.add(const Duration(hours: 9));
                String waktupost2 =
                    DateFormat('dd MMMM yyyy').format(localTime2);
                String wpcontent2 = snapshot.data![2]['content']['rendered'];
                wpcontent2 = wpcontent2.replaceAll('data-src', 'src');

                DateTime utcTime3 = DateTime.parse(snapshot.data![3]['date']);
                DateTime localTime3 = utcTime3.add(const Duration(hours: 9));
                String waktupost3 =
                    DateFormat('dd MMMM yyyy').format(localTime3);
                String wpcontent3 = snapshot.data![3]['content']['rendered'];
                wpcontent3 = wpcontent3.replaceAll('data-src', 'src');

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Nav.push(
                              context,
                              NewsDetailPage(
                                judul: wprekomendasi0,
                                kategori: snapshot.data![0]['categories'][0],
                                tanggal: waktupost0.toString(),
                                gambar: snapshot.data![0]['yoast_head_json']
                                    ['og_image'][0]['url'],
                                isi: wpcontent0,
                                link: wplink0,
                                id: snapshot.data![0]['id'],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.47,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![0]['yoast_head_json']
                                            ['og_image'][0]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    DView.spaceHeight(6),
                                    Text(
                                      wprekomendasi0,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Nav.push(
                              context,
                              NewsDetailPage(
                                judul: wprekomendasi1,
                                kategori: snapshot.data![1]['categories'][0],
                                tanggal: waktupost1.toString(),
                                gambar: snapshot.data![1]['yoast_head_json']
                                    ['og_image'][0]['url'],
                                isi: wpcontent1,
                                link: wplink1,
                                id: snapshot.data![0]['id'],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.47,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![1]['yoast_head_json']
                                            ['og_image'][0]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    DView.spaceHeight(6),
                                    Text(
                                      wprekomendasi1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Nav.push(
                              context,
                              NewsDetailPage(
                                judul: wprekomendasi2,
                                kategori: snapshot.data![2]['categories'][0],
                                tanggal: waktupost2.toString(),
                                gambar: snapshot.data![2]['yoast_head_json']
                                    ['og_image'][0]['url'],
                                isi: wpcontent2,
                                link: wplink2,
                                id: snapshot.data![0]['id'],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.47,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![2]['yoast_head_json']
                                            ['og_image'][0]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    DView.spaceHeight(6),
                                    Text(
                                      wprekomendasi2,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Nav.push(
                              context,
                              NewsDetailPage(
                                judul: wprekomendasi3,
                                kategori: snapshot.data![3]['categories'][0],
                                tanggal: waktupost3.toString(),
                                gambar: snapshot.data![3]['yoast_head_json']
                                    ['og_image'][0]['url'],
                                isi: wpcontent3,
                                link: wplink3,
                                id: snapshot.data![0]['id'],
                              ),
                            );
                          },
                          child: SizedBox(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.47,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![3]['yoast_head_json']
                                            ['og_image'][0]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    DView.spaceHeight(6),
                                    Text(
                                      wprekomendasi3,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return DView.loadingCircle();
            },
          ),
        ],
      ),
    );
  }

  dialogClaim(BuildContext context) {
    final edtComment = TextEditingController();
    final edtNama = TextEditingController();
    final edtEmail = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: SimpleDialog(
            titlePadding: const EdgeInsets.all(16),
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: const Text('Komentar'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: [
              DInput(
                controller: edtComment,
                title: 'Komentar',
                radius: BorderRadius.circular(10),
                validator: (input) => input == '' ? "Don't Empty" : null,
                minLine: 3,
                maxLine: 5,
              ),
              DView.spaceHeight(),
              DInput(
                controller: edtNama,
                title: 'Nama',
                radius: BorderRadius.circular(10),
                validator: (input) => input == '' ? "Don't Empty" : null,
              ),
              DView.spaceHeight(),
              DInput(
                controller: edtEmail,
                title: 'Email',
                radius: BorderRadius.circular(10),
                validator: (input) => input == '' ? "Don't Empty" : null,
              ),
              DView.spaceHeight(20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    FutureBuilder<void>(
                      future: WpApi.postWpNewsComment(edtNama.text,
                          edtEmail.text, edtComment.text, id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return DView.loadingCircle();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return const Text("");
                      },
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              DView.spaceHeight(8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  Divider divider() {
    return Divider(
      indent: 0,
      endIndent: 0,
      color: Colors.grey[400],
    );
  }

  Padding isiberita() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HtmlWidget(
                  isi,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* Padding isiberita() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Html(
                  data: isi,
                  style: {
                    "p": Style.fromTextStyle(
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } */

  Padding judulberita(String judul, String tanggal) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          DView.spaceHeight(6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: WpApi.fecthWpNewsCategory(kategori),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var wpkategori = snapshot.data!.name!.toUpperCase();
                    return Text(
                      "$wpkategori - ",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text(
                    "ONLINE - ",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Text(
                tanggal,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AspectRatio headerimage(BuildContext context, String gambar) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            child: Image.network(
              gambar,
              fit: BoxFit.cover,
            ),
          ),
          /* Positioned(
            top: 10,
            right: 10,
            child: SizedBox(
              height: 30,
              width: 30,
              child: FloatingActionButton.extended(
                heroTag: 'bookmark-button',
                onPressed: () {},
                label: const Icon(
                  Icons.bookmark_border,
                  size: 20,
                ),
                backgroundColor: const Color.fromARGB(125, 0, 0, 0),
                foregroundColor: Colors.white,
              ),
            ),
          ), */
          Positioned(
            top: 10,
            right: 10,
            child: SizedBox(
              height: 30,
              width: 30,
              child: FloatingActionButton.extended(
                heroTag: 'share-button',
                onPressed: () {
                  Share.share(link);
                },
                label: const Icon(
                  Icons.share_outlined,
                  size: 20,
                ),
                backgroundColor: const Color.fromARGB(125, 0, 0, 0),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox header() {
    return SizedBox(
      width: 200,
      child: Image.asset(
        AppAssets.logoHeader,
      ),
    );
  }
}
