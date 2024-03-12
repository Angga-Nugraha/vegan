part of 'components_helper.dart';

Widget myButton(BuildContext context,
    {required VoidCallback? onPressed, required String text}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text,
    ),
  );
}
