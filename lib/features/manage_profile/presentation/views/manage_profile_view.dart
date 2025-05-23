import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/manage_profile/presentation/controllers/cubits/manage_profile_cubit/manage_profile_cubit.dart'
    show ManageProfileCubit;
import 'package:edu_link/features/manage_profile/presentation/views/widgets/manage_profile_view_body.dart'
    show ManageProfileViewBody;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class ManageProfileView extends StatelessWidget {
  const ManageProfileView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: EText(getUser == null ? 'Add User' : 'Edit User'),
      centerTitle: true,
    ),
    body: BlocProvider<ManageProfileCubit>(
      create: (context) => ManageProfileCubit(),
      child: const ManageProfileViewBody(),
    ),
  );
}
