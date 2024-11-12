import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship1/LOGIN/OtpLogin.dart';

class CardSlider extends StatefulWidget {
  const CardSlider({super.key});

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  bool _next = true;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<String> _images = [
    "assets/image/people.png",
    "assets/image/job.png",
    "assets/image/login.png",
  ];
  final List<String> _titles = [
    "Fast, Simple & Hassle-free",
    "Fast, Simple & Hassle-free",
    "Fast, Simple & Hassle-free",
  ];
  final List<String> subtitle = ["Booking", "Dining", "Payment"];
  final List<String> _descriptions = [
    "Get delicious food delivered right at your doorstep at zero cost.",
    "Get delicious food delivered right at your doorstep at zero cost.",
    "Get delicious food delivered right at your doorstep at zero cost.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 600,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _images[index],
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _titles[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subtitle[index],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            _descriptions[index],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _next = true;
                        });

                        if (_currentIndex < _images.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate to login or home screen
                        }
                        // logic
                        if (_currentIndex == 2) {
                          // when login comes then it will navigate to the otp function
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpLogin()));
                        }
                      },
                      child: Text(_currentIndex < _images.length - 1
                          ? "Next"
                          : "Login"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Set the border radius here
                          ),
                          backgroundColor:
                              _next ? Colors.orange : Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _next = false;
                        });
                      },
                      child: const Text("Skip"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Set the border radius here
                          ),
                          backgroundColor:
                              !_next ? Colors.orange : Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
