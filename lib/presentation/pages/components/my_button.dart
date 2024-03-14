part of 'components_helper.dart';

Widget myButton(BuildContext context,
    {required VoidCallback? onPressed, required String text}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(250, 40),
    ),
    onPressed: onPressed,
    child: Text(
      text,
    ),
  );
}
