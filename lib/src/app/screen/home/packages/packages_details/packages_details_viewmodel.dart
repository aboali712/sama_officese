
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_officese/src/app/screen/home/packages/packages_details/packages_details_view.dart';

import '../../../../auth/auth_model/empty_response.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../models/offer_model.dart';
import 'model/PackagerDetailsResponse.dart';
import 'model/package_details_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

abstract class PackagesDetailsVieModel extends State<PackagesDetails> {
  final Dio dio = NetworkService.instance.dio; // Dio instance for network requests
  PackageDetailsModel? offerDetailsModel; // Holds the package details model

  bool isLoading = false; // Loading state indicator
  int activeIndex = 0; // Index for the active carousel item
  bool switchValue = true; // Switch value for offer status
  OfferModel? offer; // Holds the offer model
  static String offerId = ""; // ID of the current offer

  @override
  void initState() {
    // Initialize the state by fetching offer details
    getOfferDetailsApi();
    super.initState();
  }

  /// check for return html
  bool containsHtmlTags(String? text) {
    if (text == null) return false;
    // Regular expression to match any HTML tag
    final htmlTagPattern = RegExp(r'<[^>]+>');
    return htmlTagPattern.hasMatch(text);
  }

  /// Method to change the status of the offer
  Future<void> changeOfferApi(String status) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    Map<String, String> data = {
      "offer_id": offerId,
      "status": status,
    };

    try {
      // API call to change the offer status
      final response = await dio.post("v1/office/change-offer-status", data: data);

      var result = EmptyResponse(response.data!);

      setState(() {
        isLoading = false; // Hide loading indicator
      });

      if (result.status == 200) {
        // If successful, refresh the offer details and show success message
        await getOfferDetailsApi();
        toastAppSuccess(result.msg!, context);
      } else {
        // If failed, show error message
        toastApp(result.msg!, context);
      }
    } catch (e) {
      // Handle any errors
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      toastApp("An error occurred. Please try again.", context);
    }
  }

  /// Method to fetch offer details from the API
  Future<void> getOfferDetailsApi() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    Map<String, String> params = {
      "offer_id": offerId,
    };

    try {
      // API call to get the offer details
      final response = await dio.get("v1/office/offerDetails", queryParameters: params);

      var result = OffersDetailsResponse(response.data!);

      setState(() {
        isLoading = false; // Hide loading indicator
      });

      if (result.status == 200) {
        // If successful, update the offer and switch value
        setState(() {
          offer = result.data!.offerDetails;
          switchValue = offer!.status == "active";
        });
      }
    } catch (e) {
      // Handle any errors
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      toastApp("An error occurred. Please try again.", context);
    }
  }

  // Function to parse HTML and return a readable string
  String parseHtmlToText(String htmlString) {
    // Parse the HTML string
    var document = html_parser.parse(htmlString);

    // Extract the text from <li> elements
    List<String> listItems = document
        .querySelectorAll('li')
        .map((element) => '• ${element.text}')
        .toList();

    // Join the list items with new lines or bullet points
    return listItems.join('\n'); // You can use '\n• ' for bullet points
  }



}
