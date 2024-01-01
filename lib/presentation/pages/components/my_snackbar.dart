part of 'components_helper.dart';

void mySnackbar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    backgroundColor: secondaryColor,
    behavior: SnackBarBehavior.floating,
    width: MediaQuery.of(context).size.width / 2.5,
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 1),
  ));
}
