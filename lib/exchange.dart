import 'networking.dart';

const apiKey = ' EB12EF44-E13E-4F76-AAE7-FEFF7CAEEAA7';
const restCoinApi = 'https://rest.coinapi.io/v1/exchangerate/BTC';

class ExchangeModel {
  Future<dynamic> getBitcoin(String goal) async {
    NetworkHelper networkHelper =
        NetworkHelper('$restCoinApi/$goal?apikey=$apiKey');
    var coin = await networkHelper.getData();
    return coin;
  }
}
