class userInvestmentModel {
  int? annualIncome;
  int? currentSavings;
  List<Investments>? investments;
  int? totalStockInvestment;
  List<GroupedStocks>? groupedStocks;

  userInvestmentModel(
      {this.annualIncome,
      this.currentSavings,
      this.investments,
      this.totalStockInvestment,
      this.groupedStocks});

  userInvestmentModel.fromJson(Map<String, dynamic> json) {
    annualIncome = json['annualIncome'];
    currentSavings = json['currentSavings'];
    if (json['investments'] != null) {
      investments = <Investments>[];
      json['investments'].forEach((v) {
        investments!.add(new Investments.fromJson(v));
      });
    }
    totalStockInvestment = json['totalStockInvestment'];
    if (json['groupedStocks'] != null) {
      groupedStocks = <GroupedStocks>[];
      json['groupedStocks'].forEach((v) {
        groupedStocks!.add(new GroupedStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['annualIncome'] = this.annualIncome;
    data['currentSavings'] = this.currentSavings;
    if (this.investments != null) {
      data['investments'] = this.investments!.map((v) => v.toJson()).toList();
    }
    data['totalStockInvestment'] = this.totalStockInvestment;
    if (this.groupedStocks != null) {
      data['groupedStocks'] =
          this.groupedStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Investments {
  String? sId;
  String? userId;
  String? investType;
  List<Stocks>? stocks;
  List<dynamic>? mutualFunds;
  List<dynamic>? bonds;
  List<dynamic>? property;
  int? iV;

  Investments(
      {this.sId,
      this.userId,
      this.investType,
      this.stocks,
      this.mutualFunds,
      this.bonds,
      this.property,
      this.iV});

  Investments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    investType = json['investType'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stocks.fromJson(v));
      });
    }
    if (json['mutualFunds'] != null) {
      mutualFunds = <dynamic>[];
      json['mutualFunds'].forEach((v) {
        mutualFunds!.add(v);
      });
    }
    if (json['bonds'] != null) {
      bonds = <dynamic>[];
      json['bonds'].forEach((v) {
        bonds!.add(v);
      });
    }
    if (json['property'] != null) {
      property = <dynamic>[];
      json['property'].forEach((v) {
        property!.add(v);
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['investType'] = this.investType;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    if (this.mutualFunds != null) {
      data['mutualFunds'] = this.mutualFunds;
    }
    if (this.bonds != null) {
      data['bonds'] = this.bonds;
    }
    if (this.property != null) {
      data['property'] = this.property;
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Stocks {
  String? name;
  int? investedAmount;
  int? numberOfStocks;
  int? pricePerStock;
  String? sId;

  Stocks(
      {this.name,
      this.investedAmount,
      this.numberOfStocks,
      this.pricePerStock,
      this.sId});

  Stocks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    investedAmount = json['investedAmount'];
    numberOfStocks = json['numberOfStocks'];
    pricePerStock = json['pricePerStock'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['investedAmount'] = this.investedAmount;
    data['numberOfStocks'] = this.numberOfStocks;
    data['pricePerStock'] = this.pricePerStock;
    data['_id'] = this.sId;
    return data;
  }
}

class GroupedStocks {
  String? groupName;
  List<Stocks>? stocks;

  GroupedStocks({this.groupName, this.stocks});

  GroupedStocks.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
