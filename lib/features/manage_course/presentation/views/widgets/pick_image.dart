import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/features/manage_course/presentation/controllers/manage_course_cubit/manage_course_cubit.dart'
    show ManageCourseCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickImage extends StatelessWidget {
  const PickImage({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageCourseCubit>();
    final image = cubit.course.image;
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: GestureDetector(
          onTap: () async => cubit.setImage(),
          child: Stack(
            children: [
              if (image != null)
                Image.file(image, fit: BoxFit.cover)
              else
                (imageUrl?.isNotEmpty ?? false)
                    ? CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover)
                    : const Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: mBorder),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          size: 100,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
