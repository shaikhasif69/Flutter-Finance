import 'package:flutter_finance/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InvestmentNotifier extends StateNotifier<List<dynamic>?> {
  InvestmentNotifier() : super(null);
  List<dynamic> filteredData = [];
  var data =[];
  getInvestment() async {
     data= await AuthService.getInvestments();
     state=data;

    print("satete");
    print(data);
    }
  }

  

  


final investmentProvider =
    StateNotifierProvider<InvestmentNotifier, dynamic>(
        (ref) => InvestmentNotifier());