import 'package:jdolh_brands/core/class/crud.dart';
import 'package:jdolh_brands/core/constants/strings.dart';

class GoogleMapsService {
  Crud crud;
  GoogleMapsService(this.crud);

  getSearchSuggestations(
      {
      //   required String lat,
      // required String lng,
      required String input,
      required String sessiontoken,
      //required String radius,
      // String language = 'ar',
      String country = 'sa'}) async {
    final String language = 'ar';
    //var response = await crud.getData('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$country&key=$GOOGLE_MAPS_API_KEY&sessiontoken=$sessiontoken&radius=$radius&location=$lat, $lng');
    var response = await crud.getData(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:$country&key=$GOOGLE_MAPS_API_KEY&sessiontoken=$sessiontoken&language=$language');

    return response.fold((l) => l, (r) => r);
  }

  getPlaceDetails(
      {required String placeId, required String sessiontoken}) async {
    var response = await crud.getData(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&sessiontoken=$sessiontoken&key=$GOOGLE_MAPS_API_KEY&fields=geometry');

    return response.fold((l) => l, (r) => r);
  }
}
