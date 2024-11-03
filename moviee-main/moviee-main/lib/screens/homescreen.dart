import 'package:flutter/material.dart';
import 'package:movieapps/common/utils.dart';
import 'package:movieapps/models/upcoming_model.dart';
import 'package:movieapps/services/api_services.dart';
import 'package:movieapps/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upComingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upComingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: nowPlayingFuture,
                headLineText: "Now playing",
              ),
            ),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: upComingFuture,
                headLineText: "Upcoming Movies",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
