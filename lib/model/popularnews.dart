class PopularNews {
  final int? id;
  final String? title;
  final String? content;
  final String image;
  final DateTime date;
  final int kategori;

  PopularNews({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.kategori,
  });

  factory PopularNews.fromJson(Map<String, dynamic> json) => PopularNews(
        id: json["id"],
        date: DateTime.parse(json["date"]).toLocal(),
        title: json["title"]["rendered"],
        content: json["content"]["rendered"],
        image: json["yoast_head_json"]["og_image"][0]["url"],
        kategori: json['categories'][0],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "title": {
          'rendered': title,
        },
        "content": {
          'rendered': content,
        },
        "yoast_head_json": {
          'rendered': [
            {
              'url': image,
            },
          ],
        },
        "categories": [
          kategori,
        ],
      };
}

class YoastHeadJson {
  final List<OgImage>? ogImage;

  YoastHeadJson({
    required this.ogImage,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        ogImage: List<OgImage>.from(
            json["og_image"].map((x) => OgImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "og_image": List<dynamic>.from(ogImage!.map((x) => x.toJson())),
      };
}

class OgImage {
  final String url;

  OgImage({
    required this.url,
  });

  factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
