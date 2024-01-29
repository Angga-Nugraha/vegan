part of 'components_helper.dart';

void mySnackbar(BuildContext context, {required String message, Color? color}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: color ?? secondaryColor.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 450),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
    ));
}
