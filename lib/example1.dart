import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Used for => Read Only
final example1Provider = Provider<String>((ref) {
  return 'This is Example 1';
});

class Example1 extends ConsumerWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(ref.read(example1Provider)),
      ),
    );
  }
}