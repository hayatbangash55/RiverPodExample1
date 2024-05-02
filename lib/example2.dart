import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Used For => Reactive Variable
//Not recommended
final example2 = StateProvider((ref) {
  return 0;
});

class Example2 extends ConsumerWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(example2).toString(),
            ),
            TextButton(
              onPressed: () {
                ref.read(example2.notifier).state++;
              },
              child: const Text('Increment Value'),
            ),
          ],
        ),
      ),
    );
  }
}
