import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled1/example2.dart';
import 'package:untitled1/example3.dart';
import 'package:untitled1/example4.dart';
import 'package:untitled1/search_example.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: SearchUserProvider(),
      ),
    ),
  );
}


