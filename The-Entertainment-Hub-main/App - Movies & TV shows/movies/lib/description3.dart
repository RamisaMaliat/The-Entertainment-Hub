import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

class Description3 extends StatelessWidget {
  final String name,
      title,
      description,
      bannerurl,
      posterurl,
      vote,
      launch_on,
      original_language,
      first_air_date;
  final int number_of_episodes, number_of_seasons;

  const Description3(
      {Key key,
      this.name,
      this.title,
      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.launch_on,
      this.first_air_date,
      this.number_of_episodes,
      this.number_of_seasons,
      this.original_language})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: modified_text(
                        text: '⭐ Average Rating - ' + vote, size: 20)),
              ])),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(10),
            child: modified_text(text: name != null ? name : title, size: 24),
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                  text: first_air_date != null
                      ? "First Air Date - " + first_air_date
                      : "",
                  size: 16)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                  text: number_of_seasons != null
                      ? "Number of Seasons - " + number_of_seasons.toString()
                      : "",
                  size: 16)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                  text: original_language != null
                      ? 'Original Language - ' + original_language
                      : "",
                  size: 16)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(
                  text: number_of_episodes != null
                      ? 'Number of Episodes - ' + number_of_episodes.toString()
                      : "",
                  size: 16)),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: description, size: 18)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
