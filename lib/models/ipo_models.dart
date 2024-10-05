class ipoModels {
  List<IpoCalendar>? ipoCalendar;

  ipoModels({this.ipoCalendar});

  ipoModels.fromJson(Map<String, dynamic> json) {
    if (json['ipoCalendar'] != null) {
      ipoCalendar = <IpoCalendar>[];
      json['ipoCalendar'].forEach((v) {
        ipoCalendar!.add(new IpoCalendar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ipoCalendar != null) {
      data['ipoCalendar'] = this.ipoCalendar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IpoCalendar {
  String? symbol;
  String? date;
  String? exchange;
  String? name;
  String? status;
  String? price;
  int? numberOfShares;
  int? totalSharesValue;

  IpoCalendar(
      {this.symbol,
      this.date,
      this.exchange,
      this.name,
      this.status,
      this.price,
      this.numberOfShares,
      this.totalSharesValue});

  IpoCalendar.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    date = json['date'];
    exchange = json['exchange'];
    name = json['name'];
    status = json['status'];
    price = json['price'];
    numberOfShares = json['numberOfShares'];
    totalSharesValue = json['totalSharesValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['date'] = this.date;
    data['exchange'] = this.exchange;
    data['name'] = this.name;
    data['status'] = this.status;
    data['price'] = this.price;
    data['numberOfShares'] = this.numberOfShares;
    data['totalSharesValue'] = this.totalSharesValue;
    return data;
  }
}
