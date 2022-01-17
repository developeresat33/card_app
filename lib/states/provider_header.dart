import 'package:card_application/states/dashboard_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProviderHeader {
/*   Proje içerisinde durum yönetimi için kısa yoldan sadece okunabilir provider başlıklarını çağırmak amacı ile yazılmış olan statik değişken türlerimiz. */
  static var dshprovider =
      Provider.of<DashProvider>(Get.context, listen: false);
}
