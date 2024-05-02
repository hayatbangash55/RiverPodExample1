import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/usermodel.dart';

final futureUserProvider = FutureProvider<UserModel>((ref) async {
  http.Response response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  final dataJson = jsonDecode(response.body);
  return UserModel.fromJson(dataJson);
});

class Example4 extends ConsumerWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: ref.watch(futureUserProvider).when(
            data: (data) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.data?.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(data.data?[index].firstName ?? 'N/A'),
                        subtitle: Text(data.data?[index].lastName ?? 'N/A'),
                        leading: ClipOval(
                          child: Image.network(
                            data.data?[index].avatar ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
