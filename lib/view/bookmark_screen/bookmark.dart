import 'package:flutter/material.dart';
import 'package:newsapp/controller/newscontroller.dart';
import 'package:newsapp/controller/savenewscontroller.dart';
import 'package:newsapp/view/newsdetails_screen/newsdetails_screen.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
   @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<Savenewscontroller>().getnews();
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("Saved Articles",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            _searchfeild(),
            SizedBox(height: 15,),
           _bookmarknews(context)
          ],
        ),
      ),
    );
  }

  Column _bookmarknews(BuildContext context) {
     final cartstate = context.watch<Savenewscontroller>();
     var newsstate=context.watch<Newscontroller>();
    return Column(children: List.generate(cartstate.cartitem.length, (index) => Padding(
           padding: const EdgeInsets.only(bottom: 15),
           child: Container(
            decoration: BoxDecoration(
                  border: Border(bottom: BorderSide())
                ),
            height: 130,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        await context
                        .read<Savenewscontroller>()
                        .removenews(id: cartstate.cartitem[index]["id"]);
                      },
                      child: Container(
                       
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Remove",style: TextStyle(fontWeight: FontWeight.bold,),),
                        )),
                      ),
                    ),
                    
                    
                    SizedBox(height: 10,),
                    Expanded(
                      child: Container(
                        width: 250,
                        child: Text(cartstate.cartitem[index]["tittle"],
                        maxLines: 3,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    ),
                
                    
                  ],
                ),
               
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
           
                      cartstate.cartitem[index]["image"])),
                ),
              ],
            ),
           ),
         ),),);
  }

  TextFormField _searchfeild() {
    return TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),
              hintText: "Search",
              fillColor: Colors.grey.shade300,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)),),
          );
  }
}