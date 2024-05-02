import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Model
class PersonModel {
  PersonModel({
    this.name,
    this.age,
    this.job,
    this.address,
  });

  String? name;
  int? age;
  String? job;
  String? address;
}

//ViewModel
var example3Provider = StateNotifierProvider<Example3Notifier, List<PersonModel>>((ref) {
  return Example3Notifier();
});

class Example3Notifier extends StateNotifier<List<PersonModel>> {
  Example3Notifier() : super([]);

  addPerson(PersonModel personModel) {
    state = [...state, personModel];
  }
}

//View
class Example3View extends ConsumerWidget {
  const Example3View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PersonModel> personList = ref.watch(example3Provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Example 3')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: personList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(personList[index].name ?? 'N/A'),
                    Text(personList[index].address ?? 'N/A'),
                    Text('${personList[index].age ?? 'N/A'}'),
                    Text(personList[index].job ?? 'N/A'),
                  ],
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(example3Provider.notifier).addPerson(
                    PersonModel(
                      name: 'Name --',
                      address: 'Address--',
                      age: 23,
                      job: 'Job--',
                    ),
                  );
            },
            child: const Text('Add Person'),
          ),
        ],
      ),
    );
  }
}
