import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0), // Added padding for spacing
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius:
                BorderRadius.all(Radius.circular(8.0)), // Rounded corners
          ),
          child: const Icon(
            Icons.search,
            color: Colors.grey, // Adding color for better visibility
            size: 30.0, // Icon size adjustment
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'توصيل الي \n المنزل - التجمع الخامس',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(width: 8),
              Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
