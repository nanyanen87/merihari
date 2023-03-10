import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/tapbox.dart';
import 'favorite_button.dart';
import 'logo.dart';
import 'next_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // #docregion titleSection
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          const FavoriteWidget()
        ],
      ),
    );
    // #enddocregion titleSection

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    Widget tapboxSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Tapbox()
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            CallApiButton(),
            LogoWidget(),
            // LogoApp(),
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            navigateSection,
            tapboxSection,
          ],
        ),
      ),
    );
  }
}

Widget navigateSection = const Center(
    child: NavigateButton()
);
class NavigateButton extends StatelessWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(10, 30)),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NextPage(),
          ),
        );
      },
      child: const Text('next'),
    );
  }
}

class CallApiButton extends StatelessWidget {
  const CallApiButton({super.key});

  void _callAPI() async {

    const headers = {
      'Accept-Language': 'ja,en-US;q=0.9,en;q=0.8',
      'Accept-Charset': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Origin': 'https://developer.riotgames.com',
      'X-Riot-Token': 'RGAPI-50c6f4e4-7c24-4ff3-8018-a2767319a953'
    };
    var url = Uri.parse(
      'https://asia.api.riotgames.com/riot/account/v1/accounts/by-riot-id/und3fined/8540',
    );

    var response = await http.get(url, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  //   url = Uri.parse('https://reqbin.com/sample/post/json');
  //   response = await http.post(url, body: {
  //     'key': 'value',
  //   });
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _callAPI();
      },
      child: Text('call'),
    );
  }

}