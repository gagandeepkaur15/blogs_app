import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:subspace_task/blog_provider.dart';
import 'package:subspace_task/details_page.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final favoriteBlogs = blogProvider.favoriteBlogs;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
          title: Text(
            'Favourites',
            style: GoogleFonts.kalam(fontSize: 20.sp),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: ListView.builder(
            itemCount: favoriteBlogs.length,
            itemBuilder: (context, index) {
              final blog = favoriteBlogs[index];
              return Center(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      padding: EdgeInsets.all(15.sp),
                      height: 22.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
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
                            builder: (context) => DetailsPage(
                                title: blog.title, url: blog.imageUrl),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        height: 22.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: const Color.fromARGB(90, 0, 0, 0),
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
                            : const Icon(Icons.favorite_border),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            blogProvider.toggleFavorite(blog);
                          });
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
