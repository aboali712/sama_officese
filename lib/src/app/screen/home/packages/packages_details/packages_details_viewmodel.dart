import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';

abstract class PackagesDetailsVieModel extends State<PackagesDetails>{

  List<NetworkImage> productImage = [
    NetworkImage('https://www.polilingua.com/uploads/posts/singapore-language-3.jpg'),
    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
    NetworkImage('https://images.unsplash.com/photo-1565967511849-76a60a516170?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c2luZ2Fwb3JlfGVufDB8fDB8fHww'),
  ];

  int activeIndex =0;
  bool switchValue= true;
}