import 'package:flutter/material.dart';
import 'package:newsapp/controller/allnewsconroller.dart';
import 'package:newsapp/controller/detailnewscontroller.dart';

import 'package:newsapp/controller/newscontroller.dart';
import 'package:newsapp/controller/recentnewscontroller.dart';
import 'package:newsapp/controller/savenewscontroller.dart';
import 'package:newsapp/view/bottomnavibar/bottomnavibar.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Savenewscontroller.initializeDatabase();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Newscontroller(),),
      ChangeNotifierProvider(create: (context) => Savenewscontroller(),),
      ChangeNotifierProvider(create: (context) => Recentnewscontroller(),),
      ChangeNotifierProvider(create: (context) => CategoryController(),),



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Bottomnavibar(),
      ),
    );
  }
}