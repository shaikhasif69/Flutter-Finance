import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddNewInvestment extends StatefulWidget {
  const AddNewInvestment({super.key});

  @override
  State<AddNewInvestment> createState() => _AddNewInvestmentState();
}

class _AddNewInvestmentState extends State<AddNewInvestment> {
  int _currentStep = 1;

  final _ageController = TextEditingController();
  final _incomeController = TextEditingController();
  String _selectedInvestmentType = 'Stocks';
  String _selectedStockName = 'AAPL';
  double _investedAmount = 0;
  int _numberOfStocks = 0;
  double _calculatedShares = 0;
  List<Map<String, dynamic>> stockDetails = [];
  TextEditingController _selectedStockNameController = TextEditingController();
  TextEditingController _selectedAmountController = TextEditingController();
  TextEditingController _selectedNumberOfStocks = TextEditingController();

  final List<String> _investmentTypes = [
    'Stocks',
    'Mutual Funds',
    'Bonds',
    'Property'
  ];
  final DateTime now = DateTime.now();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('MMMM d, y').format(now);
  }

  @override
  void dispose() {
    _ageController.dispose();
    _incomeController.dispose();
    super.dispose();
  }

  void _calculateShares() {
    if (_numberOfStocks > 0) {
      setState(() {
        _calculatedShares = _investedAmount / _numberOfStocks;
      });
    }
  }

  void _addToProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    if (stockDetails.isNotEmpty) {
      Map<String, dynamic> requestBody = {
        "investType": "Stocks",
        "stocks": stockDetails.map((stock) {
          return {
            "name": stock['stockName'],
            "investedAmount": stock['investedAmount'].toString(),
            "numberOfStocks": stock['numberOfStocks'].toString(),
            "pricePerStock": stock['calculatedShares'].toString()
          };
        }).toList()
      };

      final response = await http.post(
        Uri.parse('https://vh-24-byte-fuse.vercel.app/users/invest'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $authToken"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
       showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Success!'),
          content: Text('You added stocks succesfully!'),
        );
      },
    );
    setState(() {
        _selectedStockNameController.text = "";
        _selectedAmountController.text = "";
        _selectedNumberOfStocks.text = "";
        _calculatedShares = 0;
         stockDetails.clear();
      });
        print('Successfully added to profile: $responseBody');
      } else {
        showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Opp!!'),
          content: Text("Something went wrong, we'll fix it right away!"),
        );
      },
    );
        print('Failed to add to profile: ${response.body}');
      }
    } else {
      showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('No Stocks!'),
          content: Text('You have not selected any stocks to Add in the Portfolio!'),
        );
      },
    );
      print("No stock details available to add to profile.");
    }
  }

  void _addMoreStocks() {
    if (_selectedStockNameController.text.isNotEmpty &&
        _selectedAmountController.text.isNotEmpty &&
        _selectedNumberOfStocks.text.isNotEmpty) {
      setState(() {
        stockDetails.add({
          'stockName': _selectedStockNameController.text,
          'investedAmount': _selectedAmountController.text,
          'numberOfStocks': _numberOfStocks,
          'calculatedShares': _calculatedShares.toString()
        });
        _selectedStockNameController.text = "";
        _selectedAmountController.text = "";
        _selectedNumberOfStocks.text = "";
        _calculatedShares = 0;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.ourPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.06),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Investment",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                Icon(Icons.notifications_active)
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(formattedDate),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    'Please select your investment type:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedInvestmentType,
                      decoration: InputDecoration(
                        labelText: 'Investment Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey[400]!, width: 1.5),
                        ),
                      ),
                      items: _investmentTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedInvestmentType = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (_selectedInvestmentType == 'Stocks') ...[
                    const Text(
                      'Enter stock details:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _selectedStockNameController,
                        decoration: InputDecoration(
                          labelText: 'Stock Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey[400]!, width: 1.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedStockName = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _selectedAmountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Invested Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey[400]!, width: 1.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _investedAmount = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _selectedNumberOfStocks,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number of Stocks',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey[400]!, width: 1.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _numberOfStocks = int.tryParse(value) ?? 0;
                            _calculateShares();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Calculated Value of Shares: $_calculatedShares'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.appBackGround)),
                          onPressed: _addMoreStocks,
                          child: const Text('Add More Stocks'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.ourPrimary)),
                          onPressed: _addToProfile,
                          child: const Text('Add To Profile'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (stockDetails.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Added Stocks:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...stockDetails.map((stock) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                  '${stock['stockName']}: Invested ₹${stock['investedAmount']}, Shares: ${stock['calculatedShares']}'),
                            );
                          }).toList(),
                        ],
                      ),
                  ],

                  // Empty container for other types for now
                  if (_selectedInvestmentType != 'Stocks') Container(),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
