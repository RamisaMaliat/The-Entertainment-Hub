import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';

class Description2 extends StatelessWidget {
  final String name, title, description, bannerurl, posterurl, vote, launch_on;

  const Description2(
      {Key key,
      this.name,
      this.title,
      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.launch_on})
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
              child:
                  modified_text(text: name != null ? name : title, size: 24)),
          Container(
            padding: EdgeInsets.only(left: 10),
          ),
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
