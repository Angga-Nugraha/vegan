part of 'components_helper.dart';

Widget myButton({required VoidCallback? onPressed, required String text}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Text(
      text,
      style: subTitleStyle.copyWith(color: Colors.white, fontSize: 14),
    ),
  );
}
