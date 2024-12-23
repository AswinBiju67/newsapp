import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/controller/allnewsconroller.dart';
import 'package:newsapp/controller/newscontroller.dart';
import 'package:newsapp/controller/recentnewscontroller.dart';
import 'package:newsapp/view/newsdetails_screen/listnews.screen.dart/listnews.dart';
import 'package:newsapp/view/newsdetails_screen/newsdetails_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await context.read<Newscontroller>().getnews();
     await context.read<Newscontroller>().getallnews();
     await context.read<Newscontroller>().recentnews();
     await context.read<Recentnewscontroller>().getproducts();
     await context.read<CategoryController>().getCategories();
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var statescreen=context.watch<Newscontroller>();
    String now = DateFormat("yyyy-MM-dd ").format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(now,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(radius: 25,
          backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/256/11186/11186790.png"),),
        )],),
      body: 
      statescreen.isLoading? Center(child: CircularProgressIndicator(),) :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Top News",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
               _Topnews(),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Recent News",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                
              ],),
              SizedBox(height: 15,),
              _recentnewss(),
              SizedBox(height: 15,),
              Divider(),
              SizedBox(height: 5,),
              _newscategory(),
              SizedBox(height: 25,),
              _newslist(context)
            ],
          ),
        ),
      ),
    );
  }

  Column _newslist(BuildContext context) {
    // var statescreen=context.watch<Newscontroller>();
    final statescreen=context.watch<CategoryController>();
    return Column(children: List.generate(statescreen.newsTopics.length, (index) => 
    statescreen.isLoading? Center(child: CircularProgressIndicator(),) :
    Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Listnews(newsid: statescreen.newsTopics[index].title,index: index,)));
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide())
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        
                        width: 250,
                        child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  statescreen.newsTopics[index].author ?? 
                                "",
                               maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                 statescreen.newsTopics[index].description ?? 
 
                                "",
                                  maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold,),),
                                SizedBox(height: 5,),
                                Text( 
                                statescreen.newsTopics[index].publishedAt.toString() ?? 
                                "",)
                              ],
                            ),      
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            fit: BoxFit.cover,
                            statescreen.newsTopics[index].urlToImage ?? 
                            "https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg",
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),),);
  }

  CarouselSlider _Topnews() {
    var statescreen=context.watch<Newscontroller>();
    return CarouselSlider.builder(itemCount:statescreen.news!.articles!.length,itemBuilder: (context, index, realIndex) => InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsdetailsScreen(newsid: statescreen.news?.articles?[index].title,index: index,),));
      },
      child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        statescreen.news?.articles?[index].urlToImage ??
                         "https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      statescreen.news?.articles?[index].title ?? 
                      "",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    Text(
                      statescreen.news?.articles?[index].content ?? 
                    "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                  ],
                ),
              ),
    ), options: CarouselOptions(
      height: 320,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.1,
      onPageChanged: (index, reason) {
        setState(() {});
      },
      scrollDirection: Axis.horizontal,
    ),);
  }

  SingleChildScrollView _newscategory() {
    final statescreen=context.watch<CategoryController>();
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: List.generate(statescreen.categories.length, (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    statescreen.categorySelection(clickedIndex: index);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: statescreen.categories==index ? Colors.black : Colors.grey.withOpacity(.2),
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(statescreen.categories[index].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                      color:statescreen.categories==index ? Colors.white : Colors.black
                      ),
                      ),
                    )),
                  ),
                ),
              ),),),
            );
  }

  SingleChildScrollView _recentnewss() {
    var recentnewsstate=context.watch<Newscontroller>();
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: List.generate(recentnewsstate.news!.articles!.length, (index) => Padding(
                padding: const EdgeInsets.only(right: 10  ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsdetailsScreen(newsid: recentnewsstate.news?.articles?[index].title,index: index,),));
                  },
                  child: Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Expanded(
                            child: Image.network(
                              height: 100,
                              fit: BoxFit.cover,
                             recentnewsstate.news?.articles?[index].urlToImage ??
                                                     "https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg"),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(recentnewsstate.news?.articles?[index].author ??  "",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                        Text(recentnewsstate.news?.articles?[index].title ?? 
                                "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                  ),
                ),
              ),),),
            );
  }

  
  }
