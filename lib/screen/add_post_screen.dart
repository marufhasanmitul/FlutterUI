import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  TextEditingController _captionController=TextEditingController();
  Uint8List? _file;



  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a Photo"),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () async {
                 Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final UserModel? userModel= Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: ()=>_selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post to"),
              centerTitle: false,
              backgroundColor: mobileSearchColor,
              actions: [
                TextButton(onPressed: () {}, child: const Text("Post"))
              ],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(userModel?.photoUrl??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqEdjObQlFk57DJp5nZDb45UuAJG_TMlFJ_pgWX2VwWA&s"),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: _captionController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Write a Caption',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Image.memory(_file!,height: 100,),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
