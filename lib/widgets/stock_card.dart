import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StockCard extends StatelessWidget {
  final String companyName;
  final String currentPrice;
  final String imagePath;
  final bool isBullMarket;

  const StockCard({
    Key? key,
    required this.companyName,
    required this.currentPrice,
    required this.imagePath,
    required this.isBullMarket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Color> bullGradientColors2 = [
     Color(0xFF7FFFDA),  
  Color(0xFF38B5E6),  
  Color(0xFF16C79A) 
    ];

    final List<Color> bearGradientColors = [
      Color(0xFFD4C4FF),  
  Color(0xFFFFA8A8),  
    ];

    final Gradient cardGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 0.8,
      colors: isBullMarket ? bullGradientColors2 : bearGradientColors,
    );

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.4,
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imagePath,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              companyName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              '₹$currentPrice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            isBullMarket
                ? Lottie.asset('assets/Lotty/profitAni.json', height: 60)
                : Lottie.asset('assets/Lotty/lossAni.json', height: 60),
          ],
        ),
      ),
    );
  }
}
