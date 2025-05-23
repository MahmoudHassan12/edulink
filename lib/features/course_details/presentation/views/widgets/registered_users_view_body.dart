import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:edu_link/features/course_details/presentation/controllers/registered_users_cubit/registered_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredUsersViewBody extends StatelessWidget {
  const RegisteredUsersViewBody({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Registered Users'),
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        BlocBuilder<RegisteredUsersCubit, RegisteredUsersState>(
          builder: (context, state) {
            if (state is RegisteredUsersSuccess) {
              final List<UserEntity>? users = state.users;
              if (users == null || users.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('No registered users found')),
                );
              }
              return SliverList.builder(
                itemBuilder: (context, index) {
                  final UserEntity user = users[index];
                  return ListTile(
                    leading: UserPhoto(user: user),
                    title: Text(user.name!),
                    subtitle: Text('Role: ${user.academicTitle ?? 'Student'}'),
                  );
                },
                itemCount: users.length,
              );
            } else if (state is RegisteredUsersLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is RegisteredUsersFailure) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.error)),
              );
            }
            return const SliverToBoxAdapter();
          },
        ),
      ],
    );
}
