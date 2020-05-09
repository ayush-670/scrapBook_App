const GOOGLE_API_KEY = 'AIzaSyAkeONWkVJ_vlVV-Ny-XasWsQwITN8g1F4';

class LocationHelper{
  static String generateLocationPreviweImage({double latitude, double longitude,}){
      return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

}
