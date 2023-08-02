import 'package:brain_teaser/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CardItem extends StatefulWidget {
  final int index;

  const CardItem({Key? key, required this.index}) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnitId = 'ca-app-pub-3940256099942544/6300978111'; //testing ad id

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void initState() {
    initBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(categories[widget.index].image),
                  fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    categories[widget.index].name,
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        isAdLoaded == true
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  height: bannerAd.size.height.toDouble(),
                  width: bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
