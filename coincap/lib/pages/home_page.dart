import 'dart:convert';

import 'package:coincap/pages/details_page.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  HTTPServices? _http;
  String? selectedCoin = "bitcoin";

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPServices>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectedDropDown(),
            _dataWidgets(),
          ],
        ),
      )),
    );
  }

  Widget _selectedDropDown() {
    List<String> coins = ["bitcoin", "ethereum", "tether", "cardano", "ripple"];
    List<DropdownMenuItem<String>> items = coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      value: selectedCoin,
      items: items,
      onChanged: (value) {
        selectedCoin = value;
        setState(() {});
      },
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 35,
      iconDisabledColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down_outlined),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: _http!.get("coins/${selectedCoin}"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num usdPrice = data["market_data"]["current_price"]["usd"];
          num changed24Hrs = data["market_data"]["price_change_percentage_24h"];
          String imageURL = data["image"]["large"];
          String des = data["description"]["en"];
          Map exchangeRates = data["market_data"]["current_price"];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DetailsPage(
                            rates: exchangeRates,
                          );
                        },
                      ),
                    );
                  },
                  child: _imageCoins(imageURL)),
              _currentPrice(usdPrice),
              _percentangeChange(changed24Hrs),
              _descriptionCard(des),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPrice(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} USD",
      style: const TextStyle(
          color: Colors.white, fontSize: 23, fontWeight: FontWeight.w400),
    );
  }

  Widget _percentangeChange(num changed) {
    return Text(
      "${changed.toString()}%",
      style: const TextStyle(color: Colors.white, fontSize: 17),
    );
  }

  Widget _imageCoins(String imageUrl) {
    return Container(
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.03),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }

  Widget _descriptionCard(String description) {
    return Container(
        height: _deviceHeight! * 0.45,
        width: _deviceWidth! * 0.90,
        margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
        padding: EdgeInsets.symmetric(
            vertical: _deviceHeight! * 0.03, horizontal: _deviceHeight! * 0.01),
        color: const Color.fromRGBO(83, 88, 206, 1.0),
        child: Text(
          description,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ));
  }
}
