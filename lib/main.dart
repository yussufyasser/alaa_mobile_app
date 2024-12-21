import 'package:fintech/Login_Screen.dart';
import 'package:fintech/Register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 


class Main{
  static String ip='ec2-13-61-142-237.eu-north-1.compute.amazonaws.com';
  static void Alert(String tittle, String message,BuildContext context){

    showDialog(
      context: context, 
      builder:(BuildContext builder){

        return SingleChildScrollView( child:  AlertDialog(

          title: Text(tittle),
          content: Text(message),
          actions: <Align>[

            Align( child:  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('ok')),
            alignment: Alignment.centerLeft),
          ],

        ));
      }

      );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FractionalNestApp());
}

class FractionalNestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fractional Nest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'TimesNewRoman', // Use Times New Roman font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterScreen(),
        '/intro': (context) => IntroductionScreen(),
      },
    );
  }
}


class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/luxury_villa_1.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Logout Button
          Positioned(
            top: 40, // Adjust position
            right: 20, // Adjust position
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); // Navigate to Login Page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Text(
                    "Welcome to Fractional-Nest",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Description about the app
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Fractional-Nest is your gateway to fractional investment in real estate. "
                      "We empower you to own shares in properties without the need for full ownership. "
                      "With Fractional-Nest, you can diversify your investments and achieve financial growth through real estate.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Section: How we work
                  Text(
                    "How We Work",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "We bring you the best real estate investment opportunities, "
                      "split into manageable shares, so you can invest in real estate without the hassle. "
                      "Fractional investments allow you to own property shares, earn rental income, and grow your wealth with ease.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home'); // Navigate to HomeScreen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D7D7F),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Go to Available Properties",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 50), // Space above footer
                ],
              ),
            ),
          ),

          // Footer
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // About Us, Privacy Policy, Contact Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // About Us
                      Text(
                        "About Us",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      // Privacy Policy
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      // Contact Info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact Info:",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            "Phone: +201115013137",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            "Email: fractionalnest@gmail.com",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Follow Us Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow Us:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Login Screen




// Register Screen




// Home Page Screen

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> properties = [
    {
      'name': 'Luxury Villa',
      'price': '\$500,000',
      'region': 'Los Angeles, CA',
      'description': 'A luxurious villa with modern amenities and a great view.',
      'minimumInvestment': '\$5,000',
      'photos': [
        'assets/luxury_villa_1.jpg',
        'assets/luxury_villa_2.jpg',
        'assets/luxury_villa_3.jpg',
      ],
    },
    {
      'name': 'Twin-House',
      'price': '\$300,000',
      'region': 'Egypt, New-Cairo',
      'description': 'An apartment located in the heart of the city.',
      'minimumInvestment': '\$3,000',
      'photos': [
        'assets/Mivida_1.jpg',
        'assets/Mivida_2.jpg',
        'assets/Mivida_3.jpg',
      ],
    },
    {
      'name': 'Mountainview',
      'price': '\$750,000',
      'region': 'Egypt, North-Coast, Mountain View',
      'description': 'A beautiful beach house with ocean views.',
      'minimumInvestment': '\$7,500',
      'photos': [
        'assets/Mountainview_1.jpg',
        'assets/MountainView_2.jpg',
        'assets/Mountainview_3.jpg',
      ],
    },
    {
      'name': 'Town-House',
      'price': '\$250,000',
      'region': 'Egypt, North-Coast, Marassi',
      'description': 'A cozy suburban home perfect for families.',
      'minimumInvestment': '\$2,500',
      'photos': [
        'assets/Townhouse_1.jpg',
        'assets/Townhouse_2.jpg',
        'assets/Townhouse_3.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Properties'),
        backgroundColor: Color(0xFF6D7D7F),
        actions: [
          // Logout button on the top right corner
          IconButton(
            icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              // Navigate to the login screen when pressed
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/', // Assuming '/' is the route for the login page
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Property List
          ListView.builder(
            itemCount: properties.length,
            padding: EdgeInsets.only(bottom: 120), // To leave space for the footer
            itemBuilder: (context, index) {
              final property = properties[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      property['photos'][0], // Use the first image as cover photo
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    property['name']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${property['region']}\nPrice: ${property['price']}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailScreen(
                          property: property,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  // About Us, Privacy Policy, Contact Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "About Us",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Phone: +201115013137\nEmail: support@fractionalnest.com",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Follow Us
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow Us:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Property Detail Screen


class PropertyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  PropertyDetailScreen({required this.property});

  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _selectedShares = 1; // Default to 1 share
  late double _investmentPrice;

  @override
  void initState() {
    super.initState();
    // Initialize investment price based on the minimum investment price and selected shares
    _investmentPrice = _selectedShares *
        double.parse(widget.property['minimumInvestment']
            .replaceAll("\$", "")
            .replaceAll(",", ""));
  }

  void _incrementShares() {
    if (_selectedShares < 10) {
      setState(() {
        _selectedShares++;
        _investmentPrice = _selectedShares *
            double.parse(widget.property['minimumInvestment']
                .replaceAll("\$", "")
                .replaceAll(",", ""));
      });
    }
  }

  void _decrementShares() {
    if (_selectedShares > 1) {
      setState(() {
        _selectedShares--;
        _investmentPrice = _selectedShares *
            double.parse(widget.property['minimumInvestment']
                .replaceAll("\$", "")
                .replaceAll(",", ""));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property['name']!),
        backgroundColor: Color(0xFF6D7D7F),
      ),
      body: Column(
        children: [
          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Image (Centered at the top)
                  Center(
                    child: Image.asset(
                      widget.property['photos'][0], // Use the first image as cover photo
                      height: 400, // Adjust the size of the image as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Button to View More Photos
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyPhotosScreen(
                            propertyPhotos: List<String>.from(widget.property['photos']),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View More Photos +',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Shares Selection
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementShares,
                      ),
                      Text(
                        '$_selectedShares Shares',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementShares,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Display Total Price
                  Text(
                    'Total Price: \$${_investmentPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Description with Bigger Font
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.property['description']!,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),

                  // Regional Area
                  Text(
                    'Regional Area: ${widget.property['region']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),

                  // Minimum Fractional Investment in a Green Rectangular Box
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green, // Green background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: Text(
                      'Minimum Fractional Investment: ${widget.property['minimumInvestment']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // White text
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Buy Shares Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            totalPrice: _investmentPrice,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Buy Shares!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // About Us, Privacy Policy, Contact Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Phone: +201115013137\nEmail: support@fractionalnest.com",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Follow Us
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Follow Us:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class PropertyPhotosScreen extends StatelessWidget {
  final List<String> propertyPhotos;

  PropertyPhotosScreen({required this.propertyPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Photos'),
        backgroundColor: Color(0xFF6D7D7F),
      ),
      body: Column(
        children: [
          // Swipeable Photos
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: propertyPhotos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        propertyPhotos[index],
                        height: 350,
                        width: double.infinity,
                        //fit: BoxFit.cover, // Make the images fit nicely
                      ),
                    );
                  },
                ),
                // Indicator for more photos (Right Arrow at the bottom)
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Advanced Description Section
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Overview
                  Text(
                    'Nearby Amenities:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Restaurants
                  Text(
                    'Restaurants:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '- The Italian Place (2.5 km, ~10 min by car)\n'
                    '- Sushi Delight (3.0 km, ~12 min by car)\n'
                    '- Cozy Burger Spot (1.5 km, ~7 min by car)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  // Cafes
                  Text(
                    'Cafes:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '- Café Aroma (1.0 km, ~5 min walk)\n'
                    '- Urban Coffee Hub (2.0 km, ~8 min by car)\n'
                    '- Morning Brew (3.5 km, ~15 min by car)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  // Public Transportation Estimate
                  Text(
                    'Public Transportation:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Estimated Time:\n'
                    '- Bus Stop: 400 m (~5 min walk)\n'
                    '- Train Station: 2.8 km (~10 min by car)\n'
                    '- Taxi/Uber Availability: Immediate (~2-5 min pickup time)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // About Us, Privacy Policy, Contact Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Phone: +201115013137\nEmail: support@fractionalnest.com",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Follow Us
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Follow Us:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.facebook, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.photo_camera, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.alternate_email, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.link, color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class PaymentScreen extends StatelessWidget {
  final double totalPrice;

  PaymentScreen({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        backgroundColor: Color(0xFF6D7D7F),
      ),
      body: Column(
        children: [
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the total price
                  Text(
                    'Total Amount to Pay for this property: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  // Visa and Mastercard Payment Option
                  Text(
                    'Choose Payment Method:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Visa Button with Image
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to CardDetailsScreen for Visa payment
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(
                                  totalPrice: totalPrice,
                                  paymentMethod: 'Visa',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/Visa.jpg', // Visa image asset
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Visa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),

                      // Mastercard Button with Image
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to CardDetailsScreen for Mastercard payment
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(
                                  totalPrice: totalPrice,
                                  paymentMethod: 'Mastercard',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/Mastercard.jpg', // Mastercard image asset
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Mastercard',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // About Us, Privacy Policy, Contact Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Phone: +201115013137\nEmail: support@fractionalnest.com",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Follow Us
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Follow Us:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.facebook, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.photo_camera, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.alternate_email, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.link, color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





class CardDetailsScreen extends StatefulWidget {
  final double totalPrice;
  final String paymentMethod;

  CardDetailsScreen({required this.totalPrice, required this.paymentMethod});

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _startInactivityTimer();
  }

  // Start or reset the inactivity timer
  void _startInactivityTimer() {
    if (_inactivityTimer != null && _inactivityTimer!.isActive) {
      _inactivityTimer!.cancel(); // Cancel the previous timer
    }
    _inactivityTimer = Timer(Duration(minutes: 2), _onInactivityTimeout); // 2 minutes timeout
  }

  // This function will be called after 2 minutes of inactivity
  void _onInactivityTimeout() {
    Navigator.pushReplacementNamed(context, '/'); // Navigate to the home page
  }

  // Reset the timer whenever the user interacts with any form field
  void _resetInactivityTimer() {
    _startInactivityTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.paymentMethod} Payment'),
        backgroundColor: Color(0xFF6D7D7F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Display the total price
              Text(
                'Total Amount of shares for this property: \$${widget.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Card Number
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                maxLength: 16, // Card number length is 16 digits
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  } else if (value.length != 16) {
                    return 'Card number must be exactly 16 digits';
                  }
                  return null;
                },
                onChanged: (value) => _resetInactivityTimer(),
              ),
              SizedBox(height: 15),

              // Photo below the CVV section
              Center(
                child: Image.asset(
                  'assets/Visa.jpg', // Your image path
                  width: 300, // Adjust the size as needed
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30),

              // Card Holder Name
              TextFormField(
                controller: _cardHolderController,
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cardholder\'s name';
                  }
                  return null;
                },
                onChanged: (value) => _resetInactivityTimer(),
              ),
              SizedBox(height: 15),

              // Expiry Date
              TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Expiry Date (DD/MM/YY)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  } else if (!RegExp(r'^\d{2}/\d{2}/\d{2}$').hasMatch(value)) {
                    return 'Expiry date must be in DD/MM/YY format';
                  }
                  return null;
                },
                onChanged: (value) => _resetInactivityTimer(),
              ),
              SizedBox(height: 15),

              // CVV
              TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                maxLength: 3, // CVV length is 3 digits
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your CVV';
                  } else if (value.length != 3) {
                    return 'CVV must be exactly 3 digits';
                  }
                  return null;
                },
                onChanged: (value) => _resetInactivityTimer(),
              ),
              SizedBox(height: 30),

              // Photo below the CVV section
              Center(
                child: Image.asset(
                  'assets/CVV.png', // Your image path
                  width: 450, // Adjust the size as needed
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Show the confirmation dialog
                    _showConfirmationDialog();
                  }
                },
                child: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Payment'),
        content: Text(
          'Are you sure you want to proceed with the payment of this exact property?\$${widget.totalPrice.toStringAsFixed(2)}?',
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Close the dialog
            },
            child: Text('No'),
          ),
          // Confirm Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Close the dialog
              _processPayment();  // Proceed with the payment process
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  // Function to handle the successful payment and navigate to the home page
  void _processPayment() {
    // Simulate payment processing here (could be an API call in real use case)

    // Show success message (you could use a SnackBar or a Toast for better UX)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment Successful!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate to Home Page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Replace `HomePage` with your actual home screen widget
      (route) => false, // This will clear the navigation stack and take you to HomePage
    );
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }
}
