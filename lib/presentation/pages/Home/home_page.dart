import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/routes.dart';
import 'package:vegan/core/styles.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:vegan/presentation/pages/components/components_helper.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import 'widgets/category_list.dart';
import 'widgets/discount_card.dart';
import '../Product/product_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              floating: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/3.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(colors: [
                          Colors.transparent,
                          Colors.black26,
                        ], radius: 1),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Vegan,',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                              if (state is UserError) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      titleTextStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      contentTextStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      contentPadding: const EdgeInsets.all(8.0),
                                      titlePadding: const EdgeInsets.all(8.0),
                                      actionsPadding: EdgeInsets.zero,
                                      title: const Text(
                                        "Something wrong !",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        state.message.toTitleCase(),
                                        textAlign: TextAlign.center,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, authPageRoutes);
                                            },
                                            child: Text(
                                              "Try Login",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              switch (state) {
                                case UserLoaded():
                                  var user = state.result.name?.toTitleCase();
                                  return FadeIn(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(user ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                title: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width - 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: myTextfield(
                      context,
                      controller: TextEditingController(),
                      border: InputBorder.none,
                      label: "Search",
                      icon: Icons.search,
                      enabled: false,
                      type: TextInputType.none,
                    ),
                  ),
                ),
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              actions: [
                GestureDetector(
                  child: const Icon(
                    FontAwesomeIcons.message,
                    size: 16,
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(width: 15.0),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    FontAwesomeIcons.bell,
                    color: backgroundColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 20.0),
              ],
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const FetchAllProduct());
            context.read<UserBloc>().add(const FetchCurrentUser());
          },
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            physics: const BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ListCategory(),
              const DiscountCard(),
              _headers(context, title: 'Top Rated', onPressed: () {}),
              const ProductListCardItem(category: "Top Rated"),
              _headers(context, title: 'All Product', onPressed: () {}),
              const ProductListCardItem(category: "All Product"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headers(BuildContext context,
      {String? title, VoidCallback? onPressed}) {
    return ListTile(
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      title: Text(
        title ?? '',
      ),
      trailing: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
                child: Text(
              "View all ",
              style: Theme.of(context).textTheme.titleSmall,
            )),
            const WidgetSpan(
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 20,
              ),
            )
          ],
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ),
    );
  }
}
