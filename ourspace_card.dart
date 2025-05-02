// import 'package:flutter/material.dart';
// import 'package:ourspace-proj/user.dart'

class OurspaceCard extends StatefulWidget {
  final User user;

  const OurspaceCard({
    Key? key,
    required this.user,
  }):super(key:key);

  @override
State<OurspaceCard> createState() => _OurspaceCardState();
}

class _OurspaceCardState extends State<OurspaceCard>{
  @override
  Widget build(BuildContext context)=> ClipRRect(
  borderRadius: BorderRadius.circular(20),
    child:Container(
      decoration:BoxDecoration(
        image: DecorationImage(
          image:NetworkImage(widget.user.urlImage),
          fit:BoxFit.cover,
          alignment: Alignment(-0.3, 0)
        ),  // DecorationImage
      ),  // Box Decoration
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            buildName(),
            const SizedBox(height: 8),
            buildStatus(),
          ],
        ),  // Column
      ) // Container
    ),  // Container
  );  // ClipRRect

Widget buildName()=>Row(
  children: [
    Text(
      style:TextStyle(
        fontSize: 32,
        colors: Colors.black,
        fontWeight: FontWeight.bold,
      ), // TextStyle
    ), // Text
    const SizedBox(width: 16),
    Text(
      '${widget.user.age}',
      style: TextStyle(
        fontSize: 32,
        color: Colors.black,
      ),

    ),
  ],
); // Row

Widget buildStatus() => Text(
  'Active',
  style: TextStyle(fontSize:20, color: Colors.black)
)
}
