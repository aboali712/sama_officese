import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';

abstract class PackagesDetailsVieModel extends State<PackagesDetails>{

  List<NetworkImage> productImage = [
    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
  ];

  int activeIndex =0;

}