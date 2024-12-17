import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapps/common/utils.dart';
import 'package:movieapps/models/tv_series_model.dart';
import 'package:movieapps/models/upcoming_model.dart';
import 'package:movieapps/screens/login_screen.dart';
import 'package:movieapps/screens/search_screen.dart';
import 'package:movieapps/services/api_services.dart';
import 'package:movieapps/widgets/custom_carousel.dart';
import 'package:movieapps/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upComingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TvSeriesModel> topRatedSeries;

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upComingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
    topRatedSeries = apiServices.getTopRatedSeries();
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // Proses sign-out
              await FirebaseAuth.instance.signOut();

              // Setelah sign-out, arahkan ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => loginScreen()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: topRatedSeries,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomCarouselSlider(data: snapshot.data!);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                future: nowPlayingFuture,
                headLineText: "Now playing",
              ),
            ),
            const SizedBox(
              height: 20,
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
