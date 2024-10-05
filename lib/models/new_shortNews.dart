class NewsModels2 {
  String? title;
  String? url;
  String? time;
  String? newsout;
  String? description;
  String? source;

  NewsModels2(
      {this.title,
      this.url,
      this.time,
      this.newsout,
      this.description,
      this.source});

  NewsModels2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    time = json['time'];
    newsout = json['newsout'];
    description = json['description'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['time'] = this.time;
    data['newsout'] = this.newsout;
    data['description'] = this.description;
    data['source'] = this.source;
    return data;
  }
}
