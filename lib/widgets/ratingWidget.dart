import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  var _ratingPageController = PageController();
  var _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(200, MediaQuery.of(context).size.height * 0.3),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: PageView(
              controller: _ratingPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildRatingText(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              color: Colors.grey,
              child: MaterialButton(
              onPressed:() {
                _hideDialog();
              }, 
              child: Text(translate('skip')),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
              onPressed:() async {
                //!TODO Implement API endpoint
                //!TODO Implement Save Rating
                _hideDialog();
              }, 
              child: Text(translate('done')),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5, 
                (index) => IconButton(
                  icon: index < _rating ? 
                  const Icon(
                    Icons.star,
                    size: 32,
                    color: Colors.amber,
                  )
                  :
                  const Icon(
                    Icons.star_border,
                    size: 32,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                ),
              ),
            ),
          ), 
        ],
      ),
    );
  }

  _buildRatingText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        Text(
          'Thanks for visiting our Restaurant',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'We\'d love to get your feedback'
        )
      ],
    );
  }
  _hideDialog() {
    if(Navigator.canPop(context)) Navigator.pop(context);
  }
}