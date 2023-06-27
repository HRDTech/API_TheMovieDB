import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/pages/details_page.dart';
import '/model/movie.dart';
import '/utils/star_calculator.dart' as starCalculator;
import 'package:sizer/sizer.dart';
import '/utils/constants.dart';
import 'custom_loading_spin_kit_ring.dart';

class MovieCard extends StatelessWidget {
  final Movie moviePreview;
  final Color themeColor;
  final int? contentLoadedFromPage;

  const MovieCard({
    super.key,
    required this.moviePreview,
    required this.themeColor,
    this.contentLoadedFromPage,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars =
        starCalculator.getStars(rating: moviePreview.rating, starSize: 2.h);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
                id: moviePreview.id,
                themeColor: themeColor),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Stack(
          children: [
            Container(
              height: 30.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Colors.black,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.2.w),
                  child: CachedNetworkImage(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                                child: CustomLoadingSpinKitRing(
                                    loadingColor: themeColor),
                              )
                            ],
                          ),
                      imageUrl: moviePreview.imageUrl!,
                      errorWidget: (context, url, error) => Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                                child: CustomLoadingSpinKitRing(
                                    loadingColor: themeColor),
                              )
                            ],
                          )),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w),
                    ),
                    color: kAppBarColor,
                    boxShadow: kBoxShadow,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 1.5.w),
                        if (stars.isNotEmpty) Row(children: stars),
                        SizedBox(height: 1.w),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text("${moviePreview.title} ",
                                      style: kBoldTitleTextStyle),
                                  Text(
                                      (moviePreview.year == "")
                                          ? ""
                                          : "(${moviePreview.year})",
                                      style: kTitleTextStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
