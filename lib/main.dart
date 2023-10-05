import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:subspace_task/blog_model.dart';
import 'package:subspace_task/blog_provider.dart';
import 'package:subspace_task/home_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(BlogAdapter());

  await Hive.openBox<Blog>('blogBox');
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ChangeNotifierProvider(
          create: (context) => BlogProvider(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),
        );
      },
    ),
  );
}
