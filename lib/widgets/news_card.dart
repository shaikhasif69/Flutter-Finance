import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:intl/intl.dart';



String formatDate(String dateString) {
  if (dateString.length != 15) {
    throw Exception("Date string must be in the format YYYYMMDDTHHMMSS");
  }
  String datePart = dateString.substring(0, 8);
  String timePart = dateString.substring(9, 15); 

  DateTime dateTime = DateTime.parse(
      "${datePart.substring(0, 4)}-${datePart.substring(4, 6)}-${datePart.substring(6, 8)} ${timePart.substring(0, 2)}:${timePart.substring(2, 4)}:${timePart.substring(4, 6)}");

  return DateFormat('MMMM d, y').format(dateTime); 
}

class NewsCard extends StatelessWidget {
  final String authorName;
  final String articalDescription;
  final String date;
  final String imagePath;

  const NewsCard({
    Key? key,
    required this.authorName,
    required this.articalDescription,
    required this.imagePath,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.62,
        decoration: BoxDecoration(
            color: MyColors.appBackGround,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1)),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 140,
              ),
            ),
            SizedBox(height: 10),
            Text(
              authorName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              articalDescription,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 3, // Limit the description to 3 lines
              overflow: TextOverflow.ellipsis, // Add ellipsis for longer text
            ),
            SizedBox(height: 10),
            Text(
              formatDate(date),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
