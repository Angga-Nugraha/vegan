part of 'components_helper.dart';

Widget myTextfield(BuildContext context,
    {required TextEditingController controller,
    required IconData icon,
    Widget? suffixIcon,
    String? hintext,
    required TextInputType type,
    InputBorder? border,
    enabled = true,
    void Function(String)? onChanged,
    String? label,
    obscure = false}) {
  return TextFormField(
    enabled: enabled,
    keyboardType: type,
    controller: controller,
    obscureText: obscure,
    style: Theme.of(context).textTheme.bodyMedium,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintext,
      label: label == null ? null : Text(label),
      border: border ?? const UnderlineInputBorder(),
      prefixIcon: Icon(
        icon,
        size: 15,
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
