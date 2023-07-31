import 'package:flutter/material.dart';
import 'package:rankcreditcard/global/global.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: appRankColor,
        title: Text(
          'Rank Interactive',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: appRankColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Add Card'),
              onTap: () {
                Navigator.pushNamed(context, '/addCard');
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Saved Cards'),
              onTap: () {
                Navigator.pushNamed(context, '/savedCards');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Banned Countries'),
              onTap: () {
                Navigator.pushNamed(context, '/bannedCountries');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              'assets/images/ranklargelogo.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addCard');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appRankColor, // Use your golden color here
                      onPrimary: Colors.black, // Set font color to black
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Add Card',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  // Set button width as a fraction of screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/savedCards');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appRankColor, // Use your golden color here
                      onPrimary: Colors.black, // Set font color to black
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Saved Cards',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  // Set button width as a fraction of screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/bannedCountries');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appRankColor, // Use your golden color here
                      onPrimary: Colors.black, // Set font color to black
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Banned Countries',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
