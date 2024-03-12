import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/routes.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/presentation/pages/components/components_helper.dart';

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
              padding: const EdgeInsets.only(top: 25.0),
              color: Theme.of(context).colorScheme.primary,
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
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )),
          Positioned(
            top: 100,
            child: Container(
              height: MediaQuery.of(context).size.height - 70,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  children: [
                    const SizedBox(height: 10.0),
                    FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: nameC,
                        label: "Nama Lengkap",
                        icon: Icons.person_2_outlined,
                        type: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: emailC,
                        label: "Email",
                        icon: Icons.email_outlined,
                        type: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: phoneC,
                        label: "Phone Number",
                        icon: Icons.phone_android_rounded,
                        type: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, shippingAddressRoutes,
                                arguments: widget.user);
                          },
                          child: const Icon(Icons.edit_location_outlined),
                        ),
                      ],
                    ),
                    BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        EasyLoading.dismiss();
                        switch (state) {
                          case UserLoading():
                            EasyLoading.show(status: "Saving...");
                          case UserUpdated():
                            EasyLoading.showSuccess(
                                state.message.toTitleCase());
                            Future.delayed(
                                const Duration(seconds: 3),
                                () => context
                                    .read<UserBloc>()
                                    .add(const FetchCurrentUser()));
                          case UserError():
                            EasyLoading.showError(state.message.toTitleCase(),
                                duration: const Duration(seconds: 3));
                            Future.delayed(
                                const Duration(seconds: 3),
                                () => context
                                    .read<UserBloc>()
                                    .add(const FetchCurrentUser()));
                          default:
                        }
                      },
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
                    const SizedBox(height: 120),
                    FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      child: myButton(context, onPressed: () {
                        context.read<UserBloc>().add(
                              UpdateUserEvent(
                                user: User(
                                  name: nameC.text,
                                  email: emailC.text,
                                  phone: phoneC.text,
                                ),
                              ),
                            );
                      }, text: 'Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}
