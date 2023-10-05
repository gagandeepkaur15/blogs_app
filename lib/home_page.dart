import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:subspace_task/blog_provider.dart';
import 'package:subspace_task/details_page.dart';
import 'package:subspace_task/favourites_page.dart';
import 'package:subspace_task/blog_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String body = '';
  List<Blog> blogs = [];
  bool isError = false;

  @override
  void initState() {
    fetchBlogsOnce();
    super.initState();
  }

  Future<void> fetchBlogsOnce() async {
    try {
      await Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
    } catch (error) {
      setState(() {
        isError = true; // Set the error flag to true on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
          title: Text(
            'SubSpace',
            style: GoogleFonts.kalam(fontSize: 20.sp),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const FavouritesPage()),
                  );
                },
                icon: const Icon(Icons.bookmark))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isError
                    ? const Center(
                        child: Text(
                          'An error occurred while fetching data.',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : blogProvider.blogs.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              for (var blog in blogProvider.blogs)
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          padding: EdgeInsets.all(15.sp),
                                          height: 22.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                blog.imageUrl,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(
                                                        title: blog.title,
                                                        url: blog.imageUrl),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 2.h),
                                            height: 22.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              color: const Color.fromARGB(
                                                  90, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 2.w,
                                          bottom: 4.h,
                                          child: SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              blog.title,
                                              style: GoogleFonts.roboto(
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: null,
                                              // overflow: TextOverflow
                                              //     .ellipsis,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4.h,
                                          right: 2.h,
                                          child: IconButton(
                                            icon: blog.isFavorite
                                                ? const Icon(Icons.favorite)
                                                : const Icon(
                                                    Icons.favorite_border),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                blogProvider
                                                    .toggleFavorite(blog);
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
