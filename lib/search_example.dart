import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final searchUserProvider = StateProvider<String>((ref) {
  return '';
});

final getUserProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  final jsonResponse = jsonDecode(response.body);
  return jsonResponse;
});

final searchControllerProvider =
    StateNotifierProvider<SearchController, List>((ref) {
  return SearchController();
});

class SearchController extends StateNotifier<List> {
  SearchController() : super([]);

  onSearchValue(String query, List<dynamic> data) {
    state = [];

    if (query.isNotEmpty) {

      final filteredData = data
          .where((element) => element['email']
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toList();

      state.addAll(filteredData);
    }
  }
}

class SearchUserProvider extends ConsumerWidget {
  const SearchUserProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllUser = ref.watch(getUserProvider);
    final searchText = ref.watch(searchUserProvider);
    final searchController = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Searching')),
      body: getAllUser.when(
        data: (data) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(searchUserProvider.notifier).state = value;
                  },
                  onEditingComplete: () {
                    ref
                        .read(searchControllerProvider.notifier)
                        .onSearchValue(searchText, data['data']);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: searchText.isNotEmpty
                      ? searchController.length
                      : data['data'].length,
                  itemBuilder: (context, index) {
                    final user = searchText.isNotEmpty
                        ? searchController[index]
                        : data['data'][index];
                    return ListTile(
                      title: Text(user['id'].toString()),
                      subtitle: Text(user['email'].toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user['avatar']),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
