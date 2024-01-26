import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/utils/managers/app_values.dart';
import '../../../../../../config/utils/styles/app_colors.dart';

class PostsInfoCard extends StatelessWidget {
  const PostsInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.numberOfPosts,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  final String title, svgSrc, date, numberOfPosts;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: AppPadding.p16),
        padding: EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: AppColors.primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppPadding.p16),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(svgSrc),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      date,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Text(numberOfPosts)
          ],
        ),
      ),
    );
  }
}
