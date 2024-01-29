part of 'components_helper.dart';

void mySnackbar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    backgroundColor: secondaryColor.withOpacity(0.7),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      left: 50,
      right: 50,
    ),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 2),
  ));
}
