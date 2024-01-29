import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan/data/utils/constant.dart';

import '../../../../data/utils/styles.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/upload_bloc/upload_bloc.dart';

class UserHeader extends StatefulWidget {
  final User user;
  const UserHeader({required this.user, super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  static File? _imageFile;

  _getOnGalery() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        context.read<UploadBloc>().add(Uploaded(image: _imageFile!));
      });
    }
  }

  _getOnCamera() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        context.read<UploadBloc>().add(Uploaded(image: _imageFile!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () {
                widget.user.image == null
                    ? () {}
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  convertUrl(widget.user.image!)),
                              radius: 50,
                            ),
                          );
                        },
                      );
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: _imageFile == null
                        ? widget.user.image == null
                            ? const AssetImage('assets/img/no_profile.jpg')
                            : NetworkImage(convertUrl(widget.user.image!))
                                as ImageProvider
                        : FileImage(File(_imageFile!.path)),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _getOnGalery();
                              Navigator.pop(context);
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 30,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Galery',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _getOnCamera();
                              Navigator.pop(context);
                            },
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.add_a_photo_rounded,
                color: secondaryColor,
                size: 24,
              ),
            )
          ],
        ),
        Text(
          widget.user.name.toTitleCase(),
          style: subTitleStyle.copyWith(color: Colors.black87),
        ),
        Text(
          widget.user.email.toTitleCase(),
          style: bodyTextStyle,
        ),
      ],
    );
  }
}
