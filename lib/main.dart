import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:subspace_task/blog_provider.dart';
import 'package:subspace_task/home_page.dart';
import 'package:hive/hive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
