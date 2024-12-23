import 'package:flutter/material.dart';
import 'package:newsapp/controller/allnewsconroller.dart';
import 'package:newsapp/controller/savenewscontroller.dart';
import 'package:provider/provider.dart';

class Listnews extends StatefulWidget {
  String? newsid;
  int? index;

   Listnews({super.key,this.newsid,this.index});

  @override
  State<Listnews> createState() => _NewsdetailsScreenState();
}

class _NewsdetailsScreenState extends State<Listnews> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await context.read<CategoryController>().getCategories();
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var statescreen=context.watch<CategoryController>();
    // final url=statescreen.articles[widget.index!].url;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(statescreen.newsTopics[widget.index!].urlToImage ??
                         "https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg")),
                  Positioned(
                    right: 10,
                    child: IconButton(onPressed: () {
                    context.read<Savenewscontroller>().addnews(context: context, tittle: statescreen.newsTopics[widget.index!].title ?? "", image: statescreen.newsTopics[widget.index!].urlToImage ?? "");
                  }, icon: Icon(Icons.bookmark_add_outlined,size: 50,color: Colors.blue,)))
                ],
              ),
               SizedBox(height: 20,),
                         Text(statescreen.newsTopics[widget.index!].publishedAt.toString() ??
                         "",style: TextStyle(),),
                         SizedBox(height: 20,),
                         Text("Reporter : ${statescreen.newsTopics[widget.index!].author.toString()}" ??
                         "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 20,),
                Text(statescreen.newsTopics[widget.index!].title ??
                         "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        
                SizedBox(height: 15,),
                Text(statescreen.newsTopics[widget.index!].description ??
                         ""
                ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(height: 15,),
                SizedBox(height: 20,),
                         Text(statescreen.newsTopics[widget.index!].content ??
                         "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                         SizedBox(height: 15,),
                Center(
                  child: InkWell(
                    onTap: () async {
  //                     if (!await launchUrl(Uri.parse(url!))) {
  //   throw Exception('Could not launch ');
  // }
                    },
                    child: Container(decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Read More",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}