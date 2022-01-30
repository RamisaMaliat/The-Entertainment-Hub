import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class SearchMovies extends StatelessWidget {
  final List movies;

  const SearchMovies({Key key, this.movies}) : super(key: key);
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
              height: 260,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                        name: movies[index]['title'],
                                        bannerurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                movies[index]['backdrop_path'],
                                        posterurl:
                                            'https://image.tmdb.org/t/p/w500' +
                                                movies[index]['poster_path'],
                                        description: movies[index]['overview'],
                                        vote: movies[index]['vote_average']
                                            .toString(),
                                        launch_on: movies[index]
                                            ['release_date'],
                                      )));
                        },
                        child: Container(
                          width: 140,
                          child: Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              movies[index]['poster_path']),
                                    ),
                                  ),
                                  height: 200,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: modified_text(
                                      size: 15,
                                      text: movies[index]['title'] != null
                                          ? movies[index]['title']
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
