import 'package:flutter/material.dart';
import 'package:newsapp/view/bookmark_screen/bookmark.dart';
import 'package:newsapp/view/home_screen/home_screen.dart';
import 'package:newsapp/view/search_screen/search.dart';

class Bottomnavibar extends StatefulWidget {
  const Bottomnavibar({super.key});

  @override
  State<Bottomnavibar> createState() => _BottomnavibarState();
}

class _BottomnavibarState extends State<Bottomnavibar> {
  int selectedindex=0;
    static const List screen=[
    HomeScreen(),
    Bookmark()

   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: screen[selectedindex],),
     bottomNavigationBar: BottomNavigationBar(
      currentIndex: selectedindex,
      selectedItemColor:Colors.blue,
      onTap: (value) {
        print(value);
        HomeScreen();
        selectedindex=value;
        setState(() {

        });
      },
       type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Bookmark"),
        ]
      )

      
    );
  }
}