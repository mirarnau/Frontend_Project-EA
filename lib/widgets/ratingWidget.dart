import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/customerService.dart';
import 'package:flutter_tutorial/services/restaurantService.dart';

import '../models/customer.dart';

class RatingWidget extends StatefulWidget {
  final Customer? customer;
  final Restaurant? restaurant;
  const RatingWidget({Key? key, required this.customer, required this.restaurant}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  RestaurantService _restaurantService = new RestaurantService();
  CustomerService _customerService = new CustomerService();
  late final Restaurant? _restaurant;
  late final Customer? _customer;
  var _ratingPageController = PageController();
  int _ratingStatic = 0;
  int _rating = 0;
  bool _isDisabled = false;
  bool _voted = false;
  
  searchRating() {
    for(var log in _customer!.ratingLog) {
      if(log['restaurant'] == _restaurant!.restaurantName) {
        _rating = log['rating'].toInt();
        _ratingStatic = log['rating'].toInt();
        _isDisabled = true;
        _voted = true;
        break;
      }
    }
  }

  @override
  void initState() {
    _customer = widget.customer;
    _restaurant = widget.restaurant;
    searchRating();
    super.initState();
  }
  
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
                onPressed: _isDisabled ? null : () async {
                  if (_voted) {
                    _restaurant!.rating.last['total'] -= _ratingStatic;
                    _restaurant!.rating.last['total'] += _rating;
                    _restaurant!.rating.last['rating'] = _restaurant!.rating.last['total'] / _restaurant!.rating.last['votes'];
                    for(var log in _customer!.ratingLog) {
                      if(log['restaurant'] == _restaurant!.restaurantName) {
                        log['rating'] = _rating;
                        break;
                      }
                    }
                  }
                  else {
                    _restaurant!.rating.last['votes'] += 1;
                    _restaurant!.rating.last['total'] += _rating;
                    _restaurant!.rating.last['rating'] = _restaurant!.rating.last['total'] / _restaurant!.rating.last['votes'];
                    Map newLog = {
                      'restaurant': _restaurant!.restaurantName,
                      'rating': _rating,
                    };
                    _customer!.ratingLog.add(newLog);
                  }
                  await _customerService.update(_customer!, _customer!.id);
                  await _restaurantService.updateRestaurant(_restaurant!, _restaurant!.id);
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
                      if(_ratingStatic == _rating) {
                        _isDisabled = true;
                      }
                      else {
                        _isDisabled = false;
                      }
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