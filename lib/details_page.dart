import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String url;
  const DetailsPage({super.key, required this.title, required this.url});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Center(
                child: Container(
                  height: 25.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        widget.url,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.title,
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
