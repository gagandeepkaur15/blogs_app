// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:subspace_task/model.dart';

class BlogProvider with ChangeNotifier {
  List<Blog> _blogs = [];
  List<Blog> _favoriteBlogs = [];

  List<Blog> get blogs => _blogs;
  List<Blog> get favoriteBlogs => _favoriteBlogs;

  Future<void> fetchBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> blogList = jsonData['blogs'];

        List<Blog> blogData = blogList.map((blog) {
          return Blog(
            id: blog['id'],
            imageUrl: blog['image_url'],
            title: blog['title'],
          );
        }).toList();

        _blogs = blogData;
        notifyListeners();

        print('Fetched data: $_blogs');
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching data');
    }
  }

  void toggleFavorite(Blog blog) {
    if (blog.isFavorite) {
      _favoriteBlogs.remove(blog); 
    } else {
      _favoriteBlogs.add(blog);
    }
    blog.isFavorite = !blog.isFavorite; 
    notifyListeners();
  }
}
