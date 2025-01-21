import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_view/d_view.dart';
//import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:siwalima_ios/config/wp_api.dart';
import 'package:siwalima_ios/pages/news_detail_page.dart';
//import 'package:siwalima/pages/views/search_view.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import 'package:intl/intl.dart';
import '../../config/nav.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  Future<List>? _mypopularnews;
  Future<List>? _mylatestnews;
  Future<List>? _mypolitiknews;
  Future<List>? _myolahraganews;
  Future<List>? _myvisinews;
  Future<List>? _mykriminalnews;
  Future<List>? _mydaerahnews;
  Future<List>? _mybanner1;
  Future<List>? _myadv1;
  Future<List>? _myadv2;
  Future<List>? _myadv3;

  @override
  void initState() {
    _mypopularnews = WpApi.fecthWpPopularNews1();
    _mylatestnews = WpApi.fecthWpNews();
    _mypolitiknews = WpApi.fecthWpNewsKategori(38);
    _myolahraganews = WpApi.fecthWpNewsKategori(31);
    _myvisinews = WpApi.fecthWpNewsKategori(25);
    _mykriminalnews = WpApi.fecthWpNewsKategori(36);
    _mydaerahnews = WpApi.fecthWpNewsKategori(37);
    _mybanner1 = WpApi.fecthWpMediaBanner1();
    _myadv1 = WpApi.fecthWpMediaAd1();
    _myadv2 = WpApi.fecthWpMediaAd2();
    _myadv3 = WpApi.fecthWpMediaAd3();
    super.initState();
  }

  Future<void> _refreshData() async {
    // This function will refresh the Future and reload the data
    setState(() {
      _mypopularnews = WpApi.fecthWpPopularNews1();
      _mylatestnews = WpApi.fecthWpNews();
      _mypolitiknews = WpApi.fecthWpNewsKategori(38);
      _myolahraganews = WpApi.fecthWpNewsKategori(31);
      _myvisinews = WpApi.fecthWpNewsKategori(25);
      _mykriminalnews = WpApi.fecthWpNewsKategori(36);
      _mydaerahnews = WpApi.fecthWpNewsKategori(37);
      _mybanner1 = WpApi.fecthWpMediaBanner1();
      _myadv1 = WpApi.fecthWpMediaAd1();
      _myadv2 = WpApi.fecthWpMediaAd2();
      _myadv3 = WpApi.fecthWpMediaAd3(); // Re-fetch the data
    });
    // Optionally, you can add some delay to simulate network latency
    await Future.delayed(const Duration(seconds: 2));
  }

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
      body: homeMainApp(),
    );
  }

  FutureBuilder<List<dynamic>> homeMainApp() {
    return FutureBuilder(
      future: _mylatestnews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Map wppost = snapshot.data![index];
                DateTime utcTime = DateTime.parse(wppost['date']);
                String waktupost = DateFormat('dd MMMM yyyy').format(utcTime);
                String wpcontent = wppost['content']['rendered'];
                wpcontent = wpcontent.replaceAll('data-src', 'src');
                String wpjudul = wppost['title']['rendered']
                    .replaceAll("#038;", "")
                    .replaceAll("&#8211;", "-");
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      Nav.push(
                        context,
                        NewsDetailPage(
                          judul: wpjudul,
                          kategori: wppost['categories'][0],
                          tanggal: waktupost.toString(),
                          gambar: wppost['yoast_head_json']['og_image'][0]
                              ['url'],
                          isi: wpcontent,
                          link: wppost['link'],
                          id: wppost['id'],
                        ),
                      );
                    },
                    child: firstNews(wppost, waktupost),
                  );
                } else if (index == 6) {
                  return Column(
                    children: [
                      divider(),
                      popularnews(),
                      divider(),
                    ],
                  );
                } else if (index == 12) {
                  return Column(
                    children: [
                      divider(),
                      latestnews(),
                      divider(),
                    ],
                  );
                } else if (index == 18) {
                  return banner1();
                } else if (index == 24) {
                  return Column(
                    children: [
                      divider(),
                      politiknews(),
                      divider(),
                    ],
                  );
                } else if (index == 30) {
                  return banner2();
                } else if (index == 36) {
                  return Column(
                    children: [
                      divider(),
                      olahraganews(),
                      divider(),
                    ],
                  );
                } else if (index == 42) {
                  return banner3();
                } else if (index == 48) {
                  return Column(
                    children: [
                      divider(),
                      visinews(),
                      divider(),
                    ],
                  );
                } else if (index == 54) {
                  return banner4();
                } else if (index == 60) {
                  return Column(
                    children: [
                      divider(),
                      kriminalnews(),
                      divider(),
                    ],
                  );
                } else if (index == 66) {
                  return Column(
                    children: [
                      divider(),
                      daerahnews(),
                      divider(),
                    ],
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Nav.push(
                        context,
                        NewsDetailPage(
                          judul: wpjudul,
                          tanggal: waktupost.toString(),
                          gambar: wppost['yoast_head_json']['og_image'][0]
                              ['url'],
                          kategori: wppost['categories'][0],
                          isi: wpcontent,
                          link: wppost['link'],
                          id: wppost['id'],
                        ),
                      );
                    },
                    child: otherNews(wppost, waktupost),
                  );
                }
              },
            ),
          );
        }
        return DView.loadingCircle();
      },
    );
  }

  FutureBuilder<List> banner4() {
    return FutureBuilder(
      future: _myadv3,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final media =
              snapshot.data![0]['yoast_head_json']['og_image'][0]['url'];
          
          if (media == null || media.isEmpty) {
          // Handle cases where the media URL is null or empty
            return const Center(
              child: Text(
                'Image not available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          
          return AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: media,
                    placeholder: (context, url) => DView.loadingCircle(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        }
        return const Text("");
      },
    );
  }

  FutureBuilder<List> banner3() {
    return FutureBuilder(
      future: _myadv2,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final media =
              snapshot.data![0]['yoast_head_json']['og_image'][0]['url'];
          
          if (media == null || media.isEmpty) {
          // Handle cases where the media URL is null or empty
            return const Center(
              child: Text(
                'Image not available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: media,
                    placeholder: (context, url) => DView.loadingCircle(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        }
        return const Text("");
      },
    );
  }

  FutureBuilder<List> banner2() {
    return FutureBuilder(
      future: _myadv1,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final media =
              snapshot.data![0]['yoast_head_json']['og_image'][0]['url'];
          
          if (media == null || media.isEmpty) {
          // Handle cases where the media URL is null or empty
            return const Center(
              child: Text(
                'Image not available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: media,
                    placeholder: (context, url) => DView.loadingCircle(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        }        
        return const Text("");
      },
    );
  }

  FutureBuilder<List> banner1() {
    return FutureBuilder(
      future: _mybanner1,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          String media =
              snapshot.data![0]['yoast_head_json']['og_image'][0]['url'];
          return AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: media,
                    placeholder: (context, url) => DView.loadingCircle(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        }
        return const Text("");
      },
    );
  }

  FutureBuilder<List> daerahnews() {
    return FutureBuilder(
      future: _mydaerahnews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Daerah",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> kriminalnews() {
    return FutureBuilder(
      future: _mykriminalnews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Kriminal",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> visinews() {
    return FutureBuilder(
      future: _myvisinews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Visi",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> olahraganews() {
    return FutureBuilder(
      future: _myolahraganews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Olahraga",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> politiknews() {
    return FutureBuilder(
      future: _mypolitiknews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Politik",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> latestnews() {
    return FutureBuilder(
      future: _mylatestnews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Berita Terbaru",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      Map wplatestnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wplatestnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wplatestnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wplatestnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wplatestnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wplatestnews['categories'][0],
                              isi: wpcontent,
                              link: wplatestnews['link'],
                              id: wplatestnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wplatestnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  FutureBuilder<List> popularnews() {
    return FutureBuilder(
      future: _mypopularnews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DView.loadingCircle();
        }
        if (snapshot.hasData) {
          return Container(
            height: 250,
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Berita Popular",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 50,
                    height: 3,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.primary)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map wppopularnews = snapshot.data![index];
                      DateTime utcTime = DateTime.parse(wppopularnews['date']);
                      DateTime localTime =
                          utcTime.add(const Duration(hours: 9));
                      String waktupost =
                          DateFormat('dd MMMM yyyy').format(localTime);
                      String wpcontent = wppopularnews['content']['rendered'];
                      wpcontent = wpcontent.replaceAll('data-src', 'src');
                      String wpjudul = wppopularnews['title']['rendered']
                          .replaceAll("&#038;", "&")
                          .replaceAll("&#8211;", "-");

                      return GestureDetector(
                        onTap: () {
                          Nav.push(
                            context,
                            NewsDetailPage(
                              judul: wpjudul,
                              tanggal: waktupost.toString(),
                              gambar: wppopularnews['yoast_head_json']
                                  ['og_image'][0]['url'],
                              kategori: wppopularnews['categories'][0],
                              isi: wpcontent,
                              link: wppopularnews['link'],
                              id: wppopularnews['id'],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: wppopularnews['yoast_head_json']
                                            ?['og_image']?[0]?['url'] ??
                                        '',
                                    placeholder: (context, url) =>
                                        DView.loadingCircle(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-image-icon.png'),
                                    fit: BoxFit.cover,
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                                Text(
                                  wpjudul,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    );
  }

  Padding otherNews(Map<dynamic, dynamic> wppost, String waktupost) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
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
                            imageUrl: wppost['yoast_head_json']?['og_image']?[0]
                                    ?['url'] ??
                                '',
                            placeholder: (context, url) =>
                                DView.loadingCircle(),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/no-image-icon.png'),
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
                          FutureBuilder(
                            future: WpApi.fecthWpNewsCategory(
                                wppost['categories'][0]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var wpkategori =
                                    snapshot.data!.name!.toUpperCase();
                                return Text(
                                  wpkategori,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                );
                              }
                              if (snapshot.data == null) {
                                return Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                );
                              }
                              return Text(
                                "",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                          ),
                          DView.spaceHeight(4),
                          Text(
                            (wppost["title"]["rendered"] ?? "")
                                .replaceAll("&#038;", "&")
                                .replaceAll("&#8211;", "-"),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DView.spaceHeight(4),
                          Text(
                            waktupost.toString(),
                            style: const TextStyle(
                              fontSize: 8,
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

  Padding firstNews(Map<dynamic, dynamic> wppost, String waktupost) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl:
                    wppost['yoast_head_json']?['og_image']?[0]?['url'] ?? '',
                placeholder: (context, url) => DView.loadingCircle(),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/no-image-icon.png'),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: const LinearGradient(
                //begin: Alignment(0,0),
                //end: Alignment(1,1),
                colors: [
                  Color.fromARGB(255, 241, 50, 50),
                  Color.fromARGB(255, 164, 36, 36),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 5,
                  offset: const Offset(1, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wppost['title']['rendered']
                      .replaceAll("&#038;", "&")
                      .replaceAll("&#8211;", "-"),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'SiwalimaNews - $waktupost',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 218, 216, 216),
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Divider divider() {
    return const Divider(
      indent: 0,
      endIndent: 0,
      color: Colors.black87,
      height: 0,
      thickness: 1,
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
      ],
    );
  }
}
