import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class RegisterCoursesViewBody extends StatelessWidget {
  const RegisterCoursesViewBody({super.key});
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const SliverAppBar(title: EText('Register Courses'), centerTitle: true),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        sliver: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final courses = snapshot.data?.courses;
            return SliverList.builder(
              itemCount: courses?.length ?? 0,
              itemBuilder: (context, index) {
                final course = courses?[index];
                return Card.filled(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: const RoundedRectangleBorder(borderRadius: sBorder),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        course!.imageUrl!,
                      ),
                      radius: 20,
                    ),
                    title: EText(course.code!),
                    subtitle: EText(course.title!),
                    trailing: Checkbox(value: false, onChanged: (_) {}),
                    onTap: () {},
                  ),
                );
              },
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomFilledButton(label: 'Register', onPressed: () {}),
        ),
      ),
    ],
  );
}
