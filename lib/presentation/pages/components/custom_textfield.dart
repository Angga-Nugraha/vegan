part of 'components_helper.dart';

Widget myTextfield(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
    required TextInputType type,
    enabled = true,
    String? label,
    obscure = false}) {
  return TextFormField(
    enabled: enabled,
    keyboardType: type,
    controller: controller,
    obscureText: obscure,
    style: bodyTextStyle,
    decoration: InputDecoration(
      label: label == null ? null : Text(label),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 10,
      ),
      prefixIcon: Icon(
        icon,
        size: 15,
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
