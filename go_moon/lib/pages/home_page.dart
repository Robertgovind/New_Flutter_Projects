import 'package:flutter/material.dart';
import 'package:go_moon/widgets/customs.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pageTitle(),
                  _bookRide(),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _astroImageWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return const Center(
      child: Text(
        "Go Moon",
        style: TextStyle(
          color: Colors.white,
          fontSize: 38,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _astroImageWidget() {
    return Container(
      height: _deviceHeight * 0.55,
      width: _deviceWidth * 0.65,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/astro_moon.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _stationsDropDownWidget() {
    return CustomDropDown(
        items: const ["Station 1 ", "Station 2", "Station 3"],
        width: _deviceWidth * 0.45);
  }

  Widget _traverllerCountDropDownWidget() {
    return CustomDropDown(
        items: const ["1 ", "2", "3", "4"], width: _deviceWidth * 0.25);
  }

  Widget _typeDropDownWidget() {
    return CustomDropDown(
        items: const ["General", "Economy", "Business"],
        width: _deviceWidth * 0.45);
  }

  Widget _bookRide() {
    return Container(
      height: _deviceHeight * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stationsDropDownWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _traverllerCountDropDownWidget(),
              _typeDropDownWidget(),
            ],
          ),
          _rideButtom()
        ],
      ),
    );
  }

  Widget _rideButtom() {
    return Container(
      width: _deviceWidth,
      margin: const EdgeInsets.only(bottom: 10, top: 3),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 92, 87, 66),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          "Book Ride",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
