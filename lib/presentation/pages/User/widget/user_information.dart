import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/data/utils/constant.dart';

import '../../../../data/utils/styles.dart';
import '../../../bloc/user_bloc/user_bloc.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;
  late TextEditingController adressC;

  bool readOnly = true;
  TextStyle style = subTitleStyle.copyWith(
    // color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            disabledColor: backgroundColor.withOpacity(0.5),
            onPressed: readOnly
                ? null
                : () {
                    setState(() {
                      readOnly = true;
                    });
                  },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            switch (state) {
              case UserLoaded():
                final user = state.result;
                nameC = TextEditingController(text: user.name.toTitleCase());
                emailC = TextEditingController(text: user.email.toTitleCase());
                phoneC = TextEditingController(text: user.phone);
                adressC =
                    TextEditingController(text: user.address.toTitleCase());
              default:
                break;
            }
            return FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Info',
                        style: style,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            readOnly = false;
                          });
                        },
                        child: Text(
                          'Edit',
                          style: bodyTextStyle.copyWith(
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 2,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTile(context, title: 'Name', controller: nameC),
                          _buildTile(context,
                              title: 'Email', controller: emailC),
                          _buildTile(context,
                              title: 'Phone', controller: phoneC),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Delivery Address',
                    style: style,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        style: bodyTextStyle,
                        readOnly: readOnly,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.justify,
                        controller: adressC,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    int? maxline,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            title,
            style: bodyTextStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            style: bodyTextStyle,
            readOnly: readOnly,
            maxLines: maxline ?? 1,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.right,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
