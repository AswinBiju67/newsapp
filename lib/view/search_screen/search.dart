import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_outlined),
                      hintText: "Search",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),),
                  ),
                  SizedBox(height: 15,),
                  Text("Recent Search",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}