import 'package:flutter_finance/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InvestmentNotifier extends StateNotifier<dynamic> {
  InvestmentNotifier() : super(null);
  List<dynamic> filteredData = [];
  getInvestment() async {
    state=AuthService.getInvestments();
    }
  }

  

  


final investmentProvider =
    StateNotifierProvider<InvestmentNotifier, dynamic>(
        (ref) => InvestmentNotifier());