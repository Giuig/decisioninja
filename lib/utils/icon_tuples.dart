import 'package:flutter/material.dart';

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}

List<Tuple2<IconData, String>> icons = [
  Tuple2(Icons.accessibility_new, 'Person'),
  Tuple2(Icons.pest_control_rodent, 'Mouse'),
  Tuple2(Icons.adb_outlined, 'Android'),
  Tuple2(Icons.bakery_dining, 'Croissant'),
  Tuple2(Icons.pets, 'Paw'),
  Tuple2(Icons.bolt, 'Lightning'),
  Tuple2(Icons.catching_pokemon, 'Pokeball'),
  Tuple2(Icons.grade, 'Star'),
  Tuple2(Icons.ramen_dining, 'Ramen'),
  Tuple2(Icons.local_florist, 'Flower'),
  Tuple2(Icons.local_pizza, 'Pizza'),
  Tuple2(Icons.palette, 'Palette'),
  Tuple2(Icons.restaurant, 'Restaurant'),
  Tuple2(Icons.sentiment_very_satisfied, 'Happy Face'),
  Tuple2(Icons.sentiment_very_dissatisfied, 'Sad Face'),
  Tuple2(Icons.whatshot, 'Fire'),
  Tuple2(Icons.wb_sunny, 'Sun'),
  Tuple2(Icons.local_gas_station, 'Gas Station'),
  Tuple2(Icons.airplanemode_active, 'Airplane'),
  Tuple2(Icons.access_alarm, 'Alarm Clock'),
  Tuple2(Icons.directions_car, 'Car'),
  Tuple2(Icons.local_mall, 'Shopping Bag'),
  Tuple2(Icons.local_movies, 'Movie Reel'),
  Tuple2(Icons.laptop, 'Laptop'),
];
