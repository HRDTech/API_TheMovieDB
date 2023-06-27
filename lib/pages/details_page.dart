import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';
import '../widgets/custom_loading_spin_kit_ring.dart';
import '/model/movie_details.dart';
import '/services/movie.dart';
import '/utils/star_calculator.dart' as starCalculator;


class DetailsPage extends StatefulWidget {
  final String id;
  final Color themeColor;

  const DetailsPage({super.key, required this.id, required this.themeColor});

  @override
  State<DetailsPage> createState() => _DetailsPageState();

  Future<MovieDetails> getMovieDetails() async {
    MovieModel movieModel = MovieModel();
    MovieDetails temp = await movieModel.getMovieDetails(movieID: id);
    return temp;
  }
}

class _DetailsPageState extends State<DetailsPage> {
  MovieDetails? movieDetails;
  List<Widget>? stars;


  @override
  void initState() {
    super.initState();
    () async {
      MovieDetails temp = await widget.getMovieDetails();
      List<Widget> temp2 =
      starCalculator.getStars(rating: temp.rating, starSize: 15.sp);

      setState(() {
        movieDetails = temp;
        stars = temp2;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (stars == null)
          ? CustomLoadingSpinKitRing(loadingColor: widget.themeColor)
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent.withOpacity(0.1),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            leading: Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            automaticallyImplyLeading: false,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 22.0.h,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'TMDB para aplicar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              background: SafeArea(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SafeArea(
                    child: SizedBox(
                      height: 22.h,
                      child: CustomLoadingSpinKitRing(
                          loadingColor: widget.themeColor),
                    ),
                  ),
                  imageUrl: movieDetails!.backgroundURL,
                  errorWidget: (context, url, error) => SafeArea(
                    child: SizedBox(
                      height: 22.h,
                      child: CustomLoadingSpinKitRing(
                          loadingColor: widget.themeColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.h),
                      child: Wrap(
                        children: [
                          Text(
                            "${movieDetails!.title} ",
                            style: kDetailScreenBoldTitle,
                          ),
                          Text(
                            (movieDetails!.year == "")
                                ? ""
                                : "(${movieDetails!.year})",
                            style: kDetailScreenRegularTitle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.h),
                      child: Row(children: stars!),
                    ),
                    SizedBox(height: 3.h),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: Row(
                            children:
                            movieDetails!.getGenresList(context)),
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
                if (movieDetails!.overview != "")
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.h, vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 1.h,
                              left: 1.h,
                              bottom: 1.h,
                            ),
                            child: Text(kStoryLineTitleText,
                                style: kSmallTitleTextStyle),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 1.h,
                                  left: 1.h,
                                  top: 1.h,
                                  bottom: 4.h),
                              child: Text(
                                movieDetails!.overview,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFFC9C9C9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
