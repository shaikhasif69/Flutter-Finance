import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:flutter_finance/services/auth_services.dart';

class Quiz extends StatefulWidget {

  
  
  
  @override
  State<StatefulWidget> createState() {
    
    return QuizList();
    // TODO: implement createState
    throw UnimplementedError();
  }}

    int i=0;
  class QuizList extends State<Quiz>{
    @override
  void initState() {
   WidgetsBinding.instance!.addPostFrameCallback((_) {
    i=0;
  // executes after build
});
    // TODO: implement initState
    super.initState();
  }
    void fun(){
      setState(() {
        
      });
    }

    Widget build(context){
      return Scaffold( backgroundColor: MyColors.ourPrimary ,
        appBar: AppBar(backgroundColor: MyColors.ourPrimary,title: Text("Finance"),
        
      ),body: SingleChildScrollView(child: i==0?intro(context,fun):i==1?question1(context, fun): i==2?question2(context,fun):i==3?question3(context, fun) : i==4?question4(context, fun) : i==5?question5(context, fun) : Padding(padding: EdgeInsets.all(22),child:Center(child: Container(child: Column(children: [SizedBox(height: 300,), Icon(Icons.done_all_rounded,color: Colors.white,size: 150,),Text("DONE",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),)],),)) ,)),
      );
    }
  }

  Widget intro(context ,fun){
    return Column(children: [
        SizedBox( height: MediaQuery.of(context).size.height*0.35, child: Image.asset("assets/images/quizPg1.png")),        InkWell(onTap: (){
          i=1;
          fun();



        }, child: SizedBox( height: MediaQuery.of(context).size.height*0.5, child: Image.asset("assets/images/quiz1img2.png")))
      ],);
  }


Widget question5(context,fun){
    return SizedBox(width: double.infinity,
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
         children: [SizedBox(height: 30,),
         Text("Question 5" ,style: TextStyle(color: Colors.white,fontSize: 22),),
         Padding(
           padding: const EdgeInsets.all(24.0),
           child: Container( decoration: BoxDecoration( color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            
            width: double.infinity,height: MediaQuery.of(context).size.height*0.35 ,child: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(data[4]['question'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 42, 12, 136)),),
               ),
             ),
           ),),
         ),

      SizedBox(height: 20,),

         option(4, 0,fun,context),
           option(4, 1,fun,context),
             option(4, 2,fun,context),

        ],),
    );
  }

Widget question4(context,fun){
    return SizedBox(width: double.infinity,
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
         children: [SizedBox(height: 30,),
         Text("Question 4" ,style: TextStyle(color: Colors.white,fontSize: 22),),
         Padding(
           padding: const EdgeInsets.all(24.0),
           child: Container( decoration: BoxDecoration( color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            
            width: double.infinity,height: MediaQuery.of(context).size.height*0.35 ,child: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(data[3]['question'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 42, 12, 136)),),
               ),
             ),
           ),),
         ),

      SizedBox(height: 20,),

         option(3, 0,fun,context),
           option(3, 1,fun,context),
             option(3, 2,fun,context),

        ],),
    );
  }

Widget question3(context,fun){
    return SizedBox(width: double.infinity,
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
         children: [SizedBox(height: 30,),
         Text("Question 3" ,style: TextStyle(color: Colors.white,fontSize: 22),),
         Padding(
           padding: const EdgeInsets.all(24.0),
           child: Container( decoration: BoxDecoration( color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            
            width: double.infinity,height: MediaQuery.of(context).size.height*0.35 ,child: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(data[2]['question'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 42, 12, 136)),),
               ),
             ),
           ),),
         ),

      SizedBox(height: 20,),

         option(2, 0,fun,context),
           option(2, 1,fun,context),
             option(2, 2,fun,context),

        ],),
    );
  }
Widget question2(context,fun){
    return SizedBox(width: double.infinity,
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
         children: [SizedBox(height: 30,),
         Text("Question 2" ,style: TextStyle(color: Colors.white,fontSize: 22),),
         Padding(
           padding: const EdgeInsets.all(24.0),
           child: Container( decoration: BoxDecoration( color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            
            width: double.infinity,height: MediaQuery.of(context).size.height*0.35 ,child: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(data[1]['question'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 42, 12, 136)),),
               ),
             ),
           ),),
         ),

      SizedBox(height: 20,),

         option(1, 0,fun,context),
           option(1, 1,fun,context),
             option(1, 2,fun,context),

        ],),
    );
  }
   Widget question1(context,fun){
    return SizedBox(width: double.infinity,
      child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
         children: [SizedBox(height: 30,),
         Text("Question 1" ,style: TextStyle(color: Colors.white,fontSize: 22),),
         Padding(
           padding: const EdgeInsets.all(24.0),
           child: Container( decoration: BoxDecoration( color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            
            width: double.infinity,height: MediaQuery.of(context).size.height*0.35 ,child: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(data[0]['question'],style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 42, 12, 136)),),
               ),
             ),
           ),),
         ),

      SizedBox(height: 20,),

         option(0, 0,fun,context),
           option(0, 1,fun,context),
             option(0, 2,fun,context),

        ],),
    );
  }
List<int> seletedIint=[0,0,0,0,0];
  Widget option(question,index,fun ,context){
  
    return InkWell(onTap: () async{
      seletedIint[question]=index+1;
data[question]['options'][0]['h']= 0==index? 1:0;
data[question]['options'][1]['h']=01==index? 1:0;
data[question]['options'][2]['h']=02==index? 1:0;
fun();
 await Future.delayed(Duration(milliseconds: 100));
i=i+1;
fun();
if(i==5){
  print(seletedIint);
  showDialog(context: context, builder: (builder){
    return AlertDialog( backgroundColor: Colors.transparent,content: Center(child: CircularProgressIndicator(),),);

   
  });print(seletedIint);
   var res=await AuthService.updateQuiz(seletedIint);
   if(res=="done"){    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Updated")));
    
   }else{
    Navigator.of(context).pop();
    
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error occured")));
   }
}

fun();
    },
      child: Container(
        child: Padding(padding: EdgeInsets.symmetric( horizontal: 24,vertical: 15),
               child: Container(width: double.infinity, height: 80,child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Center(child: Text(data[question]['options'][index]['option'],style: TextStyle(color: Colors.white,fontSize: 16),)),
               ),
               decoration: BoxDecoration( color: data[question]['options'][index]['h']==0?null:const Color.fromARGB(255, 255, 144, 81),border: Border.all(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20))),),
             ),
      ),
    );
  }


 List<Map> data= [
    {
        "_id": "66ffc8bb9e6428cfd9510aac",
        "question": "How would you react if your investments dropped by 10% in a month?",
        "options": [
            {
              "h":0,
                "option": "Sell all investments",
                "points": 1,
                "_id": "66ffc8bb9e6428cfd9510aad"
            },
            {  "h":0,
                "option": "Hold for recovery",
                "points": 2,
                "_id": "66ffc8bb9e6428cfd9510aae"
            },
            {  "h":0,
                "option": "Buy more shares",
                "points": 3,
                "_id": "66ffc8bb9e6428cfd9510aaf"
            }
        ],
        "__v": 0
    },
    {
        "_id": "66ffc8bb9e6428cfd9510ab0",
        "question": "What type of growth do you prefer?",
        "options": [
            {  "h":0,
                "option": "Steady, low risk",
                "points": 1,
                "_id": "66ffc8bb9e6428cfd9510ab1"
            },
            {  "h":0,
                "option": "Moderate, balanced growth",
                "points": 2,
                "_id": "66ffc8bb9e6428cfd9510ab2"
            },
            {  "h":0,
                "option": "High, aggressive growth",
                "points": 3,
                "_id": "66ffc8bb9e6428cfd9510ab3"
            }
        ],
        "__v": 0
    },
    {
        "_id": "66ffc8bb9e6428cfd9510ab4",
        "question": "If you lost 10% of your investment, how would you feel?",
        "options": [
            {  "h":0,
                "option": "Extremely anxious",
                "points": 1,
                "_id": "66ffc8bb9e6428cfd9510ab5"
            },
            {  "h":0,
                "option": "Somewhat concerned",
                "points": 2,
                "_id": "66ffc8bb9e6428cfd9510ab6"
            },
            {  "h":0,
                "option": "Motivated to invest",
                "points": 3,
                "_id": "66ffc8bb9e6428cfd9510ab7"
            }
        ],
        "__v": 0
    },
    {
        "_id": "66ffc8bb9e6428cfd9510ab8",
        "question": "What is your investment horizon?",
        "options": [
            {  "h":0,
                "option": "Less than one year",
                "points": 1,
                "_id": "66ffc8bb9e6428cfd9510ab9"
            },
            {  "h":0,
                "option": "One to five years",
                "points": 2,
                "_id": "66ffc8bb9e6428cfd9510aba"
            },
            {  "h":0,
                "option": "Over five years",
                "points": 3,
                "_id": "66ffc8bb9e6428cfd9510abb"
            }
        ],
        "__v": 0
    },
    {
        "_id": "66ffc8bb9e6428cfd9510abc",
        "question": "How do you view financial risks?",
        "options": [
            {  "h":0,
                "option": "Avoid at all",
                "points": 1,
                "_id": "66ffc8bb9e6428cfd9510abd"
            },
            {  "h":0,
                "option": "Accept some risk",
                "points": 2,
                "_id": "66ffc8bb9e6428cfd9510abe"
            },
            {  "h":0,
                "option": "Seek high risk",
                "points": 3,
                "_id": "66ffc8bb9e6428cfd9510abf"
            }
        ],
        "__v": 0
    }
];