import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/fire_store_method.dart';
import 'package:instagram_clone/resources/storage_method.dart';
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
  bool _isLoading=false;

  void postImage(
      String uid,
      String username,
      String profileImage,
      )async{
    setState(() {
      _isLoading=true;
    });
    try{
      String res = await FireStoreMethod().uploadPost(
          _captionController.text,
          _file!,
          uid,
          username,
          profileImage,
      );
      
      if(res=='success'){

        if(mounted){
          setState(() {
            _isLoading=false;

          });



          showMySnackBar(context, 'Posted');

          clearImage();

        }

      }else{
        if(mounted){
          setState(() {
            _isLoading=false;
          });
          showMySnackBar(context, res);
        }

      }

    }catch(e){
      if(mounted){
        showMySnackBar(context, e.toString());
      }
    }

  }



  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a Photo"),
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


  void clearImage(){
    setState(() {
      _file=null;
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
                  clearImage();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Post to"),
              centerTitle: false,
              backgroundColor: mobileSearchColor,
              actions: [
                TextButton(onPressed: () {
                  postImage(userModel?.uid??'', userModel?.username??'', userModel?.photoUrl??'');

                }, child: const Text("Post"))
              ],
            ),
            body: Column(
              children: [
                _isLoading?const LinearProgressIndicator():Container(),
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
