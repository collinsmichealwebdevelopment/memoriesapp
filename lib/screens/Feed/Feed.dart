import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memories/screens/Feed/Feed_helpers.dart';


class Feed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Color(0xFF100E20),
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context, listen: false).appBar(context),
      body: Provider.of<FeedHelpers>(context, listen: false).feedBody(context),
    );
  }
}