part of 'components_helper.dart';

Widget myTextfield(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
    required TextInputType type,
    obscure = false}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black38,
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(1, 2), // changes position of shadow
        ),
      ],
    ),
    child: TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 10,
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
        ),
        suffixIcon: suffixIcon,
      ),
    ),
  );
}
