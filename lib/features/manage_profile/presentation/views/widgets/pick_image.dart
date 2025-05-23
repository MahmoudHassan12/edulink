import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickImage extends StatelessWidget {
  const PickImage({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: GestureDetector(
      onTap: () => context.read<ManageProfileCubit>().setImage(),
      child: CircleAvatar(
        radius: 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: Builder(
            builder: (context) {
              final UserEntity? user = context.watch<ManageProfileCubit>().user;
              final File? image = user?.image;
              final String? imageUrl = user?.imageUrl;
              return image != null
                  ? Image.file(image, fit: BoxFit.cover)
                  : imageUrl?.isNotEmpty ?? false
                  ? CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover)
                  : const Icon(Icons.add_photo_alternate_rounded, size: 48);
            },
          ),
        ),
      ),
    ),
  );
}
