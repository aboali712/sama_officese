class SettingsModel {
  int? id;
  String? about;
  String? privacy;
  String? terms;
  String? address;
  String? appName;
  String? appLogo;
  String? phone;
  String? email;
  String? whats;
  String? facebookUrl;
  String? twitterUrl;
  String? snapchatUrl;
  String? instagramUrl;
  String? facebookPixel;
  String? twitterPixel;
  String? googlePixel;
  String? snapchatPixel;
  String? tiktokPixel;
  String? office_terms ;
  String? consultationsPhone;
  String? consultationsStart;
  String? consultationsEnd;
  String? androidVersion;
  String? iosVersion;
  String? office_android_version;
  String? office_ios_version;


  SettingsModel(
      {this.id,
        this.about,
        this.privacy,
        this.terms,
        this.address,
        this.appName,
        this.appLogo,
        this.phone,
        this.email,
        this.whats,
        this.facebookUrl,
        this.twitterUrl,
        this.snapchatUrl,
        this.instagramUrl,
        this.facebookPixel,
        this.twitterPixel,
        this.googlePixel,
        this.snapchatPixel,
        this.tiktokPixel,
      this. office_terms,
        this.consultationsPhone,
        this.consultationsStart,
        this.consultationsEnd,
        this.androidVersion,
        this.iosVersion,
        this.office_android_version,
        this.office_ios_version
      });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
    privacy = json['privacy'];
    terms = json['terms'];
    address = json['address'];
    appName = json['app_name'];
    appLogo = json['app_logo'];
    phone = json['phone'];
    email = json['email'];
    whats = json['whats'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    snapchatUrl = json['snapchat_url'];
    instagramUrl = json['instagram_url'];
    facebookPixel = json['facebook_pixel'];
    twitterPixel = json['twitter_pixel'];
    googlePixel = json['google_pixel'];
    snapchatPixel = json['snapchat_pixel'];
    tiktokPixel = json['tiktok_pixel'];
    office_terms = json['office_terms'];
    consultationsPhone = json['consultations_phone'];
    consultationsStart = json['consultations_start'];
    consultationsEnd = json['consultations_end'];
    androidVersion = json['android_version'];
    iosVersion = json['ios_version'];
    office_android_version = json['office_android_version'];
    office_ios_version = json['office_ios_version'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    data['privacy'] = this.privacy;
    data['terms'] = this.terms;
    data['address'] = this.address;
    data['app_name'] = this.appName;
    data['app_logo'] = this.appLogo;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['whats'] = this.whats;
    data['facebook_url'] = this.facebookUrl;
    data['twitter_url'] = this.twitterUrl;
    data['snapchat_url'] = this.snapchatUrl;
    data['instagram_url'] = this.instagramUrl;
    data['facebook_pixel'] = this.facebookPixel;
    data['twitter_pixel'] = this.twitterPixel;
    data['google_pixel'] = this.googlePixel;
    data['snapchat_pixel'] = this.snapchatPixel;
    data['tiktok_pixel'] = this.tiktokPixel;
    data['office_terms'] = this.office_terms;
    data['consultations_phone'] = this.consultationsPhone;
    data['consultations_start'] = this.consultationsStart;
    data['consultations_end'] = this.consultationsEnd;
    data['android_version'] = this.androidVersion;
    data['ios_version'] = this.iosVersion;
    data['office_android_version'] = this.office_android_version;
    data['office_ios_version'] = this.office_ios_version;

    return data;
  }
}