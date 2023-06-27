import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdb/utils/constants.dart';

import '../widgets/bottom_navigation.dart';
import '../widgets/bottom_navigation_item.dart';
import '../widgets/custom_loading_spin_kit_ring.dart';
import '../widgets/movie_card_container.dart';
import '../widgets/shadowless_floating_button.dart';
import '/widgets/custom_main_appbar_content.dart';
import '/services/movie.dart';
import '/widgets/movie_card.dart';
import '/utils/scroll_top_with_controller.dart' as scrollTop;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? _scrollController;
  bool showBackToTopButton = false;
  Color? themeColor;
  int? activeInnerPageIndex;
  List<MovieCard>? _movieCards;
  bool showSlider = true;
  String title = kHomeScreenTitleText;
  int bottomBarIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeColor = kMainBlueColor;
    () async {
      _scrollController = ScrollController()
        ..addListener(() {
          setState(() {
            showBackToTopButton = (_scrollController!.offset >= 200);
          });
        });
      activeInnerPageIndex = 0;
      setState(() {
        loadData();
      });
    }();
  }

  @override
  void dispose() {
    if (_scrollController != null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        shadowColor: Colors.transparent.withOpacity(0.1),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'TMDB para aplicar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: (_movieCards == null)
          ? CustomLoadingSpinKitRing(loadingColor: themeColor)
          : (_movieCards!.isEmpty)
          ? const Center(child: Text(k404Text))
          : MovieCardContainer(
        scrollController: _scrollController!,
        themeColor: themeColor!,
        movieCards: _movieCards!,
      ),
      floatingActionButton: showBackToTopButton
          ? ShadowlessFloatingButton(
        iconData: Icons.keyboard_arrow_up_outlined,
        onPressed: () {
          setState(() {
            scrollTop.scrollToTop(_scrollController!);
          });
        },
        backgroundColor: themeColor,
      )
          : null,
    );
  }

  Future<void> loadData() async {
    MovieModel movieModel = MovieModel();
    _movieCards =  await movieModel.getMovies(
        themeColor: themeColor!);
    setState(() {
      scrollTop.scrollToTop(_scrollController!);
      showBackToTopButton = false;
    });
  }

  void pageSwitcher(int index) {
    setState(() {
      bottomBarIndex = (index == 2) ? 2 : 1;
      title = (index == 2) ? kFavoriteScreenTitleText : kHomeScreenTitleText;
      showSlider = !(index == 2);
      _movieCards = null;
      loadData();
    });
  }
}
