import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';
class FeedCard extends StatelessWidget {
  final snap;
  const FeedCard({
    super.key,required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(snap['profileUrl']),
              ),
              const SizedBox(width: 10,),
              Text("${snap['username']}",style: const TextStyle(fontSize: 18,color: primaryColor),),
              const Spacer(),
              IconButton(onPressed: (){}, icon:const Icon(Icons.more_vert) )
            ],
          ),
          const SizedBox(height: 15,),
          Image.network(snap['postUrl'],height: 250,width:double.infinity,fit: BoxFit.cover,),
          Row(
            children: [
              IconButton(onPressed: (){}, icon:const FaIcon(FontAwesomeIcons.solidHeart,color: Colors.red,) ),
              IconButton(onPressed: (){}, icon:const FaIcon(FontAwesomeIcons.commentDots,) ),
              IconButton(onPressed: (){}, icon:const FaIcon(FontAwesomeIcons.paperPlane,) ),
              const Spacer(),
              IconButton(onPressed: (){}, icon:const FaIcon(FontAwesomeIcons.bookmark,) ),
            ],
          ),
           Text("${snap['likes'].length} Likes",style: TextStyle(color: primaryColor),),
          const SizedBox(height: 5,),
          RichText(text: TextSpan(
              text: snap['username'],
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text:snap['description'],
                    style: const TextStyle(fontWeight: FontWeight.normal)
                )
              ]
          )),
          const SizedBox(height: 5,),
          const Text("View all 200 Comments"),
          const SizedBox(height: 5,),
           Text(
            DateFormat.yMMMd().format(
                snap['datePublished'].toDate(),
            )
          ),


        ],
      ),
    );
  }
}