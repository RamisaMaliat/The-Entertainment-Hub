import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets/nowplaying.dart';
import 'package:movie_app_flutter/widgets/searchmovies.dart';
import 'package:movie_app_flutter/widgets/searchtv.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:movie_app_flutter/widgets/tvontheair.dart';
import 'package:movie_app_flutter/widgets/upcoming.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
	brightness: Brightness.dark, 
	primaryColor: Colors.black
	),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '7dd946448b4c8d8e154b907c96ca4379';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZGQ5NDY0NDhiNGM4ZDhlMTU0YjkwN2M5NmNhNDM3OSIsInN1YiI6IjYxNzhkZmM0OTI0Y2U2MDA2NGQ0YTgxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.i3zsyk2cDr29e7Zfv90pwPjqUZdL04xq2hWow9Eu2ew';
  List trendingmovies = [];
  List topratedmovies = [];
  List tvpopular = [];
  List tvontheair = [];
  List nowplaying = [];
  List upcoming = [];
  List result = [];

  String querystring = "";
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController textEditingController2 = new TextEditingController();

  String currentpage = "0";

  Movies movies;

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    Map tvontheairresult = await tmdbWithCustomLogs.v3.tv.getOnTheAir();
    Map nowplayingresult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map upcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tvpopular = tvresult['results'];
      tvontheair = tvontheairresult['results'];
      nowplaying = nowplayingresult['results'];
      upcoming = upcomingresult['results'];
    });
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      querystring = "";
      if (buttonText == "Home") {
        currentpage = "0";
      }
      if (buttonText == "Movies") {
        currentpage = "1";
      }
      if (buttonText == "TV Shows") {
        currentpage = "2";
      }
      if (buttonText == "Search Movies") {
        currentpage = "3";
      }
      if (buttonText == "Search TV Shows") {
        currentpage = "4";
      }
    });
  }

  void _search() async {
    setState(() {
      querystring = textEditingController.text;
    });

    if (querystring == "") return;

    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map queryresult =
        await tmdbWithCustomLogs.v3.search.queryMovies(querystring);
    setState(() {
      result = queryresult['results'];
    });

    _buttonPressed("Search Movies");
  }

  void _search2() async {
    setState(() {
      querystring = textEditingController2.text;
    });

    if (querystring == "") return;

    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map queryresult =
        await tmdbWithCustomLogs.v3.search.queryTvShows(querystring);
    setState(() {
      result = queryresult['results'];
    });

    _buttonPressed("Search TV Shows");
  }

  Widget _buildButton(String buttonText, Color buttonColor) {
    Color bg;
    if (currentpage == "0" && buttonText == "Home")
      bg = Colors.white;
    else if (currentpage == "1" && buttonText == "Movies")
      bg = Colors.white;
    else if (currentpage == "2" && buttonText == "TV Shows")
      bg = Colors.white;
    else if (currentpage == "3" && buttonText == "Movies")
      bg = Colors.white;
    else if (currentpage == "4" && buttonText == "TV Shows")
      bg = Colors.white;
    else
      bg = Colors.black;

    return Container(
      margin: EdgeInsets.all(3),
      height: 52,
      child: TextButton(
        onPressed: () {
          _buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: buttonColor,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: bg,
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.currentpage == "0")
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: modified_text(
                text: 'Movies & TV Shows', color: Colors.red, size: 25),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Table(children: [
                TableRow(
                  children: [
                    _buildButton("Home", Colors.black),
                    _buildButton("Movies", Colors.white),
                    _buildButton("TV Shows", Colors.white),
                  ],
                )
              ]),

              SizedBox(
                height: 10,
              ),

              TrendingMovies(trending: trendingmovies), //trending
              TopRatedMovies(toprated: topratedmovies), //top rated movies
              TV(tv: tvpopular), //popular tv shows
              NowPlaying(movies: nowplaying), //movies playing now in theatres
              TVontheair(tv: tvontheair), //latest tv shows
              Upcoming(movies: upcoming), //upcoming movies
            ],
          ));
    if (this.currentpage == "1")
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: modified_text(
              text: 'Movies & TV Shows',
              size: 25,
              color: Colors.red,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Table(children: [
                TableRow(
                  children: [
                    _buildButton("Home", Colors.white),
                    _buildButton("Movies", Colors.black),
                    _buildButton("TV Shows", Colors.white),
                  ],
                )
              ]),

              Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: textEditingController,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Overpass'),
                  decoration: InputDecoration(
                    icon: IconButton(
                      iconSize: 30,
                      alignment: Alignment.centerLeft,
                      hoverColor: Colors.red,
                      icon: Icon(Icons.search),
                      onPressed: _search,
                    ),
                    hintText: "Search movies",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'Overpass'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              TopRatedMovies(toprated: topratedmovies), //top rated movies
              NowPlaying(movies: nowplaying), //movies playing now in theatres
              Upcoming(movies: upcoming), //upcoming movies
            ],
          ));
    if (this.currentpage == "2")
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: modified_text(
              text: 'Movies & TV Shows',
              color: Colors.red,
              size: 25,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Table(children: [
                TableRow(
                  children: [
                    _buildButton("Home", Colors.white),
                    _buildButton("Movies", Colors.white),
                    _buildButton("TV Shows", Colors.black),
                  ],
                )
              ]),
              Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: textEditingController2,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Overpass'),
                  decoration: InputDecoration(
                    hintText: "Search tv shows",
                    icon: IconButton(
                      iconSize: 30,
                      alignment: Alignment.centerLeft,
                      hoverColor: Colors.red,
                      icon: Icon(Icons.search),
                      onPressed: _search2,
                    ),
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'Overpass'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              TV(tv: tvpopular), //popular tv shows
              TVontheair(tv: tvontheair), //latest tv shows
            ],
          ));
    if (this.currentpage == "3") {
      if (result != null)
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: modified_text(
                text: 'Movies & TV Shows',
                size: 25,
                color: Colors.red,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Table(children: [
                  TableRow(
                    children: [
                      _buildButton("Home", Colors.white),
                      _buildButton("Movies", Colors.black),
                      _buildButton("TV Shows", Colors.white),
                    ],
                  )
                ]),

                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Overpass'),
                    decoration: InputDecoration(
                      icon: IconButton(
                        iconSize: 30,
                        alignment: Alignment.centerLeft,
                        hoverColor: Colors.red,
                        icon: Icon(Icons.search),
                        onPressed: _search,
                      ),
                      hintText: "Search movies",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'Overpass'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SearchMovies(movies: result), //top rated movies
              ],
            ));
      else {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: modified_text(
                text: 'Movies & TV Shows',
                size: 25,
                color: Colors.red,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Table(children: [
                  TableRow(
                    children: [
                      _buildButton("Home", Colors.white),
                      _buildButton("Movies", Colors.black),
                      _buildButton("TV Shows", Colors.white),
                    ],
                  )
                ]),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Overpass'),
                    decoration: InputDecoration(
                      icon: IconButton(
                        iconSize: 30,
                        alignment: Alignment.centerLeft,
                        hoverColor: Colors.red,
                        icon: Icon(Icons.search),
                        onPressed: _search,
                      ),
                      hintText: "Search movies",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'Overpass'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
      }
    }

    if (this.currentpage == "4") {
      if (result != null) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: modified_text(
                  text: 'Movies & TV Shows', color: Colors.red, size: 25),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Table(children: [
                  TableRow(
                    children: [
                      _buildButton("Home", Colors.white),
                      _buildButton("Movies", Colors.white),
                      _buildButton("TV Shows", Colors.black),
                    ],
                  )
                ]),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditingController2,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Overpass'),
                    decoration: InputDecoration(
                      hintText: "Search tv shows",
                      icon: IconButton(
                        iconSize: 30,
                        alignment: Alignment.centerLeft,
                        hoverColor: Colors.red,
                        icon: Icon(Icons.search),
                        onPressed: _search2,
                      ),
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'Overpass'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SearchTV(tv: result) //latest tv shows
              ],
            ));
      } else
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: modified_text(
                  text: 'Movies & TV Shows', color: Colors.red, size: 25),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Table(children: [
                  TableRow(
                    children: [
                      _buildButton("Home", Colors.white),
                      _buildButton("Movies", Colors.white),
                      _buildButton("TV Shows", Colors.black),
                    ],
                  )
                ]),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditingController2,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Overpass'),
                    decoration: InputDecoration(
                      hintText: "Search tv shows",
                      icon: IconButton(
                        iconSize: 30,
                        alignment: Alignment.centerLeft,
                        hoverColor: Colors.red,
                        icon: Icon(Icons.search),
                        onPressed: _search2,
                      ),
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: 'Overpass'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
    }
  }
}