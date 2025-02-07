import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Liste des écrans d'introduction
  final List<Map<String, String>> pages = [
    {
      "title": "Welcome to the Future\nof Payments",
      "subtitle":
          "Experience seamless, secure, and smart\npayments anywhere, anytime.",
      "image": "assets/images/anim4.jpg",
    },
    {
      "title": "Secure &\nFast Payments",
      "subtitle": "Enjoy seamless transactions with\ntop-notch security.",
      "image": "assets/images/anim3.jpg",
    },
    {
      "title": "Manage Your\nFinances Easily",
      "subtitle": "Track your expenses and savings\nin one place.",
      "image": "assets/images/anim1.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double pageOffset = 0;
                  // Sécurisation de l'accès à pageOffset
                  if (_pageController.hasClients &&
                      _pageController.page != null) {
                    pageOffset = _pageController.page! - index;
                  }

                  return Stack(
                    children: [
                      // Background image with animation
                      Transform.translate(
                        offset: Offset(pageOffset * -20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(pages[index]["image"] ??
                                  'assets/images/anim1.jpg'), // Image par défaut
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Skip button
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    pages.length - 1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  "SKIP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            Spacer(),

                            // Title
                            Transform.translate(
                              offset: Offset(pageOffset * -20, 0),
                              child: Opacity(
                                opacity: (1 - pageOffset.abs()).clamp(0.0, 1.0),
                                child: Text(
                                  pages[index]["title"] ??
                                      'Default Title', // Titre par défaut
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Subtitle
                            Transform.translate(
                              offset: Offset(pageOffset * 40, 0),
                              child: Opacity(
                                opacity: (1 - pageOffset.abs()).clamp(0.0, 1.0),
                                child: Text(
                                  pages[index]["subtitle"] ??
                                      'Default Subtitle', // Sous-titre par défaut
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 40),

                            // Open Account button (affiché sur toutes les pages)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "OPEN AN ACCOUNT",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Page indicators at the bottom
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.white : Colors.white54,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Next page button
          Positioned(
            bottom: 10,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                if (_currentPage < pages.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),

          // Previous page button (ajouté à gauche)
          Positioned(
            bottom: 10,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                if (_currentPage > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
