class NewsModels {
  String? title;
  String? url;
  String? timePublished;
  List<String>? authors;
  String? summary;
  String? bannerImage;
  String? source;
  String? sourceDomain;

  NewsModels(
      {this.title,
      this.url,
      this.timePublished,
      this.authors,
      this.summary,
      this.bannerImage,
      this.source,
      this.sourceDomain});

  NewsModels.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    timePublished = json['time_published'];
    authors = json['authors'].cast<String>();
    summary = json['summary'];
    bannerImage = json['banner_image'];
    source = json['source'];
    sourceDomain = json['source_domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['time_published'] = this.timePublished;
    data['authors'] = this.authors;
    data['summary'] = this.summary;
    data['banner_image'] = this.bannerImage;
    data['source'] = this.source;
    data['source_domain'] = this.sourceDomain;
    return data;
  }
}