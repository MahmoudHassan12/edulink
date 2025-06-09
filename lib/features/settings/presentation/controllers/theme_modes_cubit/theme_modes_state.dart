part of 'theme_modes_cubit.dart';

@immutable
final class SeedColorsState {
  const SeedColorsState({
    this.color,
    this.isAmoledSelected,
    this.isAppleDevice,
  });
  final MaterialColor? color;
  final bool? isAmoledSelected;
  final bool? isAppleDevice;
  SeedColorsState copyWith({
    final MaterialColor? color,
    final bool? isAmoledSelected,
    final bool? isAppleDevice,
  }) => SeedColorsState(
    color: color ?? this.color,
    isAmoledSelected: isAmoledSelected ?? this.isAmoledSelected,
    isAppleDevice: isAppleDevice ?? this.isAppleDevice,
  );

  SeedColorsState setColor(final MaterialColor? color) =>
      copyWith(color: color);
  SeedColorsState toggleAmoled({final bool? value}) =>
      copyWith(isAmoledSelected: value);
  SeedColorsState toggleAppleDevice({final bool? value}) =>
      copyWith(isAppleDevice: value);
}

final class _SeedColorsInitial extends SeedColorsState {
  _SeedColorsInitial()
    : super(
        color: SeedColorsCubit.defaultColor,
        isAmoledSelected: false,
        isAppleDevice: false,
      );
}
