import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/routes.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/presentation/pages/components/components_helper.dart';

import '../../../../core/styles.dart';
import '../../../bloc/user_bloc/user_bloc.dart';

class UserInfo extends StatefulWidget {
  final User user;

  const UserInfo({required this.user, super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  String? address;

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameC = TextEditingController(text: widget.user.name!.toTitleCase());
    emailC = TextEditingController(text: widget.user.email!.toTitleCase());
    phoneC = TextEditingController(text: widget.user.phone);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 15.0),
              color: foregroundColor,
              child: ListTile(
                minVerticalPadding: 10.0,
                minLeadingWidth: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'User Information',
                  textAlign: TextAlign.center,
                  style: titleStyle.copyWith(color: backgroundColor),
                ),
              )),
          Positioned(
            top: 70,
            child: Container(
              height: MediaQuery.of(context).size.height - 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'User Info',
                      ),
                      const SizedBox(height: 10.0),
                      FadeInRight(
                        duration: const Duration(seconds: 1),
                        child: myTextfield(
                          controller: nameC,
                          hintText: 'Name',
                          label: "Nama Lengkap",
                          icon: Icons.person_2_outlined,
                          type: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInLeft(
                        duration: const Duration(seconds: 1),
                        child: myTextfield(
                          controller: emailC,
                          label: "Email",
                          hintText: 'Email',
                          icon: Icons.email_outlined,
                          type: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInRight(
                        duration: const Duration(seconds: 1),
                        child: myTextfield(
                          controller: phoneC,
                          label: "Phone Number",
                          hintText: 'Phone',
                          icon: Icons.phone_android_rounded,
                          type: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Address',
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, shippingAddressRoutes,
                                  arguments: widget.user);
                            },
                            child: Text(
                              "Change Address",
                              style: subTitleStyle.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoaded) {
                            if (state.result.address!.provinsi != null ||
                                state.result.address!.kota != null ||
                                state.result.address!.kecamatan != null ||
                                state.result.address!.detailAddress != null ||
                                state.result.address!.postalCode != null) {
                              address =
                                  "${state.result.address!.detailAddress}, ${state.result.address!.kecamatan}, ${state.result.address!.kota}, ${state.result.address!.provinsi}, ${state.result.address!.postalCode}";
                            } else {
                              address = "Alamat belum ditetapkan";
                            }
                          }
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              address!.toTitleCase(),
                              textAlign: TextAlign.justify,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          switch (state) {
            case UserLoading():
              EasyLoading.show(status: "Saving...");
            case UserUpdated():
              EasyLoading.showSuccess(state.message.toTitleCase());
              Future.delayed(const Duration(seconds: 3),
                  () => context.read<UserBloc>().add(const FetchCurrentUser()));
            case UserError():
              EasyLoading.showError(state.message.toTitleCase(),
                  duration: const Duration(seconds: 3));
              Future.delayed(const Duration(seconds: 3),
                  () => context.read<UserBloc>().add(const FetchCurrentUser()));
            default:
          }
        },
        child: TextButton(
            onPressed: () {
              context.read<UserBloc>().add(
                    UpdateUserEvent(
                      user: User(
                        name: nameC.text,
                        email: emailC.text,
                        phone: phoneC.text,
                      ),
                    ),
                  );
            },
            child: const Text('Save')),
      ),
    );
  }
}
