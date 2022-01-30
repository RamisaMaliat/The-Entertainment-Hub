import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description3.dart';

class SearchTV extends StatelessWidget {
  final List tv;

  const SearchTV({Key key, this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: '',
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              // color: Colors.red,
              height: 260,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description3(
                                        name: tv[index]['name'],
                                        bannerurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                tv[index]['backdrop_path'],
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                tv[index]['poster_path'],
                                        description: tv[index]['overview'],
                                        vote: tv[index]['vote_average']
                                            .toString(),
                                        launch_on: tv[index]['release_date'],
                                        number_of_episodes: tv[index]
                                            ['number_of_episodes'],
                                        number_of_seasons: tv[index]
                                            ['number_of_seasons'],
                                        first_air_date: tv[index]
                                            ['first_air_date'],
                                        original_language: tv[index]
                                            ['original_language'],
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          // color: Colors.green,
                          width: 140,
                          child: Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                tv[index]['backdrop_path']),
                                        fit: BoxFit.cover),
                                  ),
                                  height: 200,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: modified_text(
                                      size: 15,
                                      text: tv[index]['original_name'] != null
                                          ? tv[index]['original_name']
                                          : 'Loading'),
                                )
                              ],
                            ),
                          ),
                        ));
                  }))
        ],
      ),
    );
  }
}
