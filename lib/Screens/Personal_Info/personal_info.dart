import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  int _currentStep = 1;

  final _ageController = TextEditingController();
  final _incomeController = TextEditingController();
  String _selectedDependents = '1';
  String _selectedEducation = 'Graduation';
  String _selectedHealthStatus = 'Healthy';
  List<String> selectedInvestments = [];
  final List<String> _educationLevels = [
    'Graduation',
    'Degree',
    'Doctorate',
    'Masters',
    'PhD'
  ];
  final List<String> _dependents = ['1', '2', '3', '4', '5'];
  double _currentSavings = 1000;
  List<String> selectedFutureGoals = [];

  @override
  void dispose() {
    _ageController.dispose();
    _incomeController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    setState(() {
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.ourPrimary,
      appBar: AppBar(
        backgroundColor: MyColors.ourPrimary,
        elevation: 0,
        title:
            const Text("Personal Info", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() {
                _currentStep--;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    _currentStep == 1 ? _buildFirstStep() : _buildSecondStep(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstStep() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please fill out your details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
              ),
              
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDependents,
              decoration: InputDecoration(
                labelText: 'Number of Dependents',
                labelStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              iconSize: 30,
              items: _dependents.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDependents = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration:  InputDecoration(
                labelText: 'Income (in your currency)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedHealthStatus,
              decoration: const InputDecoration(
                labelText: 'Health Ailments',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              ),
              items: ["Healthy", "Minor Disease", "Major Disease"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHealthStatus = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedEducation,
              decoration:  InputDecoration(
                labelText: 'Highest Education',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              ),
              items: _educationLevels.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEducation = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _goToNextStep,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondStep() {
    List<String> futureGoals = [
      "Marriage",
      "Buy Home",
      "Children Education",
      "Children Marriage",
      "Startup",
      "Business",
      "Buy Vehicle"
    ];

    List<String> investments = [
      "Low-risk bonds",
      "Mixed mutual funds",
      "Stocks",
      "Conservative bonds",
      "High-dividend stocks",
      "ETFs",
      "Aggressive growth stocks",
      "Real estate",
      "Annuity",
      "Tech stocks"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please provide your financial details:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10), 
          ),
          padding: const EdgeInsets.all(8),
          child: MultiSelectDialogField(
            items:
                futureGoals.map((goal) => MultiSelectItem(goal, goal)).toList(),
            title: const Text("Select Future Goal"),
            buttonText: const Text("Future Goal"), 
            onConfirm: (values) {
              setState(() {
                selectedFutureGoals = values.cast<String>();
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Current Savings Slider
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100], // Light background
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Savings (in Rupees)',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Slider(
                value: _currentSavings,
                min: 1000,
                max: 1000000,
                divisions: 1000,
                label: _currentSavings.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSavings = value;
                  });
                },
              ),
              Text('₹${_currentSavings.round()}'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100], 
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: MultiSelectDialogField(
            items: investments
                .map((investment) => MultiSelectItem(investment, investment))
                .toList(),
            title: const Text("Select Existing Investments"),
            buttonText:
                const Text("Existing Investments"),
            onConfirm: (values) {
              setState(() {
                selectedInvestments = values.cast<String>();
              });
            },
          ),
        ),
        const SizedBox(height: 20),

         Center(
          child: ElevatedButton(
           onPressed: () async{
String msg="";
            if(_ageController.text==""){
              msg="Age is needed";
            }else if(selectedFutureGoals.isEmpty){
              msg ="Future goals empty";
            }else if(selectedInvestments.isEmpty){
                      msg ="investment  empty";
            }
            if(msg!=""){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }else{

            
              showDialog( barrierDismissible: false,context: context, builder: (context){return AlertDialog(backgroundColor: Colors.transparent,
                content: Center(child: CircularProgressIndicator(),),
              );});
              String res= await AuthService.updatePersonalInfo(int.parse(_ageController.text), _selectedHealthStatus, selectedFutureGoals.join(',') ,int.parse(_selectedDependents),_incomeController,_selectedEducation,selectedInvestments.join(","),_currentSavings);
              
             if(res=="done"){
              Navigator.of(context).pop();
                Navigator.of(context).pop();
                
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Upadated")));
             }else{
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error Accoured")));
             }}
            // Handle form submission or API call
          },
          child: const Text('Submit'),
          ),
         )
      ],
    );
  }
}
