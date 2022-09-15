import '../models/webPage.dart';

const BASE_URL = "https://app.congresso.aidp.it/";
const API_URL = "https://app.congresso.aidp.it/admin/ws/";

class MyApplicationUrl {
  static Uri notifications = Uri.parse(API_URL + 'lista_notifiche.php');
  static Uri news = Uri.parse(API_URL + 'getNews.php');
  static Uri advertisement = Uri.parse(API_URL + 'getAdv.php');
  static Uri token = Uri.parse(API_URL + 'register_token.php');
}

List<WebPage> webPages = [
  WebPage(name: "HOME", link: BASE_URL),
  WebPage(name: "AGENDA", link: BASE_URL + "lagenda.php"),
  WebPage(name: "PROTAGONISTI", link: BASE_URL + "i-protagonisti.php"),
  WebPage(name: "PARTNER & SPONSOR", link:  "https://www.aidp.it/portale/partner/"),
  WebPage(name: "MAPPA", link: BASE_URL + "mappa.php"),
  WebPage(name: "SOSTENIBILITÀ", link: BASE_URL +"sostenibilita.php"),
  WebPage(name: "MOBILITÀ", link: BASE_URL + "mobilita.php"),
  WebPage(name: "TERRITORIO", link: BASE_URL + "territorio.php"),
  WebPage(name: "CONCORSO", link: BASE_URL +"concorso.php"),
  WebPage(name: "FUORICONGRESSO", link: BASE_URL + "fuoricongresso.php"),
  WebPage(name: "INFO & UTILITIES", link: BASE_URL + "info.php"),
  WebPage(name: "BOOK", link: BASE_URL + "book.php"),

];
