import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
 static final String baseUrl = "http://192.168.137.124:3000/users";
 static final String versal="https://vh-24-byte-fuse.vercel.app/users";
 static final String django="http://192.168.137.108:8080/ai/computePortfolio/";
 static late  SharedPreferences pref;
static Future<SharedPreferences> getPref()async{
  pref=await SharedPreferences.getInstance();
 return pref;
}

  Future<Map<String, dynamic>> signUp(String email, String username, String password) async {
    try {
      print("Signing up with: $email, $username");
      var temail = email.trim();
      var tusername = username.trim();
      var tpassword = password.trim();
      
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': temail,
          'username': tusername,
          'password': tpassword,
        }),
      );

      if (response.statusCode == 200) {
        print("Sign-up successful");
        final body = jsonDecode(response.body);
        final user = body['user'];
        final token = body['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setString('userId', user['_id']);
        await prefs.setString('username', user['username']);
        await prefs.setString('email', user['email']);

        return {'success': true, 'user': user, 'token': token};
      } else {
        print("Sign-up failed: ${response.statusCode}");
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'],
        };
      }
    } catch (e) {
      print("Error during sign-up: $e");
      return {
        'success': false,
        'message': 'An error occurred during sign-up.',
      };
    }
  }

  static Future<String> updatePersonalInfo(age,healthCondition,futureGoal,noOfeDepen,income,edu,invest,sav)async{

    try {var  data={"age":age,
    "noOfDependent":noOfeDepen,
    "annualIncome":income,
    "highestEDU":edu,
    "currentSaving":sav,
   "healthCondition":healthCondition,  "futurefinancialgoal":futureGoal,
   "existingInvestments":invest
   }
 ;    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
    var res=await http.patch(Uri.parse('https://vh-24-byte-fuse.vercel.app/users/editProfile',),headers:  {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken', 
        });
    if(res.statusCode==200){
print(res.body);
      return "done";

    } print(res.body);
    return "fail";
      
    } catch (e) {
      print("SSSSSs");
      print(e.toString());
      return "fail";
      
    }
   

  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      print("Signing in with: $email");

      var temail = email.trim();
      var tpassword = password.trim();

      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': temail,
          'password': tpassword,
        }),
      );

      if (response.statusCode == 201) {
        print("Sign-in successful");
        final body = jsonDecode(response.body);
        final user = body['user'];
        final token = body['token'];
        final risk= body['riskTolarence'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
            await prefs.setString('riskApitite', risk);
        await prefs.setString('userId', user['_id']);
        await prefs.setString('username', user['username']);
        await prefs.setString('email', user['email']);

        return {'success': true, 'user': user, 'token': token};
      } else if (response.statusCode == 404) {
        final body = jsonDecode(response.body);
        return {
          'success': false,
          'message': body['message'] ?? 'User not found or invalid credentials',
        };
      } else {
        print("Sign-in failed: ${response.statusCode}");
        return {
          'success': false,
          'message': 'An unknown error occurred',
        };
      }
    } catch (e) {
      print("Error during sign-in: $e");
      return {
        'success': false,
        'message': 'An error occurred during sign-in',
      };
    }
  }

  Future<Map<String, dynamic>> editProfile({
    String? username,
    int? age,
    double? annualIncome,
    int? numberOfDependent,
    String? healthCondition, 
    String? highestEdu, 
    List<String>? futureFinancialGoal, 
    List<String>? existingInvestments,
    double? currentSavings,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');
      String? userId = prefs.getString('userId'); 

      if (authToken == null) {
        return {'success': false, 'message': 'User not authenticated'};
      }

      Map<String, dynamic> requestBody = {};

      if (username != null) requestBody['username'] = username;
      if (age != null) requestBody['age'] = age;
      if (annualIncome != null) requestBody['annualIncome'] = annualIncome;
      if (numberOfDependent != null) requestBody['numberOfDependent'] = numberOfDependent;
      if (currentSavings != null) requestBody['currentSavings'] = currentSavings;
      if (healthCondition != null) requestBody['healthCondition'] = healthCondition;
      if (highestEdu != null) requestBody['highestEdu'] = highestEdu;
      if (futureFinancialGoal != null && futureFinancialGoal.isNotEmpty) {
        requestBody['futurefinancialgoal'] = futureFinancialGoal;
      }
      if (existingInvestments != null && existingInvestments.isNotEmpty) {
        requestBody['existingInvestments'] = existingInvestments;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/users/edit-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken', 
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final updatedUser = body['user'];
        
        if (updatedUser['username'] != null) {
          await prefs.setString('username', updatedUser['username']);
        }

        print("Profile updated successfully: $updatedUser");
        return {'success': true, 'user': updatedUser};
      } else {
        print("Profile update failed: ${response.statusCode}");
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      print("Error during profile update: $e");
      return {
        'success': false,
        'message': 'An error occurred during profile update',
      };
    }
  }

static Future<String> updateQuiz(data)async{
  // try {
  print("ssssss");
    print(data);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,List<int>> d={"answers":data};

;      String? authToken = prefs.getString('authToken');
    var res=await http.post(Uri.parse(baseUrl+"/submit-risk"),body: jsonEncode(d),headers: {
       'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken', 
        });
    if(res.statusCode==200){
    var resp=json.decode(res.body);
   pref.setString("riskApitite", resp['riskCategory']);
   return "done";



    }else {
      print(res.body);
      return "fail";
    }
  // } catch (e) {
    // print(e.toString());
    return "fail";
  // }
}



static  Future<dynamic> getInvestments()async{
  try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
       var authToken= await prefs.getString('authToken');
    var res= await http.post(Uri.parse(django),body: 
  
          "Bearer $authToken"
     );
    if(res.statusCode==200){
      print(res.body);
    }else{
      print(res.body);
    }
  } catch (e) {
    
  }
}
}
