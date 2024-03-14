import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/styles.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/presentation/pages/components/components_helper.dart';

import '../../../bloc/user_bloc/user_bloc.dart';

class ShippingAddress extends StatefulWidget {
  final User user;

  const ShippingAddress({required this.user, super.key});

  @override
  State<ShippingAddress> createState() => _UserInfoState();
}

class _UserInfoState extends State<ShippingAddress> {
  final String key = "Shipping Address";
  late TextEditingController _detailController;
  late TextEditingController _provinsiController;
  late TextEditingController _kotaController;
  late TextEditingController _kecamatanController;
  late TextEditingController _postController;

  late GoogleMapController mapController;
  final Map<String, Marker> _markers = <String, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();
    _detailController.dispose();
    _provinsiController.dispose();
    _kotaController.dispose();
    _kecamatanController.dispose();
    _postController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _detailController = TextEditingController(
        text: widget.user.address!.detailAddress?.toTitleCase() ?? "");
    _provinsiController = TextEditingController(
        text: widget.user.address!.provinsi?.toTitleCase() ?? "");
    _kotaController = TextEditingController(
        text: widget.user.address!.kota?.toTitleCase() ?? "");
    _kecamatanController = TextEditingController(
        text: widget.user.address!.kecamatan?.toTitleCase() ?? "");
    _postController = TextEditingController(
        text: widget.user.address!.postalCode?.toString() ?? "");
    if (widget.user.address!.geo.lat != null &&
        widget.user.address!.geo.long != null) {
      _markers[key] = Marker(
        markerId: const MarkerId("1"),
        position: LatLng(
            widget.user.address!.geo.lat!, widget.user.address!.geo.long!),
        infoWindow: InfoWindow(
          title: key,
        ),
      );
      setState(() {});
    }
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
              padding: const EdgeInsets.only(top: 30.0),
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
                    color: backgroundColor,
                  ),
                ),
                title: Text(
                  'Shipping Address',
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
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                  children: [
                    FadeInLeft(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: _provinsiController,
                        label: "Provinsi",
                        icon: Icons.local_attraction_outlined,
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: _kotaController,
                        label: "Kota",
                        icon: Icons.location_city_rounded,
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        controller: _kecamatanController,
                        label: "Kecamatan",
                        icon: Icons.location_on_outlined,
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        label: "Kode Pos",
                        controller: _postController,
                        icon: Icons.code,
                        type: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      duration: const Duration(seconds: 1),
                      child: myTextfield(
                        context,
                        label: "Detail Alamat",
                        controller: _detailController,
                        icon: Icons.home_work_outlined,
                        type: TextInputType.streetAddress,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text("Marked on the map"),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: FadeIn(
                        child: GoogleMap(
                          myLocationEnabled: true,
                          mapType: MapType.normal,
                          compassEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: widget.user.address!.geo.lat == null
                                  ? const LatLng(-6.200000, 106.816666)
                                  : _markers.values
                                      .map((e) => e.position)
                                      .first,
                              zoom: 14),
                          onMapCreated: _onMapCreated,
                          markers: _markers.values.toSet(),
                          onTap: (argument) {
                            final marker = Marker(
                              markerId: const MarkerId("1"),
                              position: argument,
                              infoWindow: InfoWindow(
                                title: key,
                              ),
                            );

                            setState(() {
                              _markers[key] = marker;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        EasyLoading.dismiss();
                        switch (state) {
                          case UserLoading():
                            EasyLoading.show(status: "Saving...");
                          case UserLoaded():
                            EasyLoading.showSuccess("Saved");
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
                      child: FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: UnconstrainedBox(
                          child: myButton(context, onPressed: () {
                            if (_provinsiController.text.isNotEmpty ||
                                _kotaController.text.isNotEmpty ||
                                _kecamatanController.text.isNotEmpty ||
                                _detailController.text.isNotEmpty) {
                              context.read<UserBloc>().add(
                                    ChangeAddressEvent(
                                      address: Address(
                                        detailAddress: _detailController.text,
                                        provinsi: _provinsiController.text,
                                        kota: _kotaController.text,
                                        kecamatan: _kecamatanController.text,
                                        postalCode:
                                            int.parse(_postController.text),
                                        geo: Geo(
                                          lat: _markers.values
                                              .map((e) => e.position.latitude)
                                              .first,
                                          long: _markers.values
                                              .map((e) => e.position.longitude)
                                              .first,
                                        ),
                                      ),
                                    ),
                                  );
                            }
                          }, text: "Save"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
