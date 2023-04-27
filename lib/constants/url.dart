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
  WebPage(name: "AGENDA", link: BASE_URL + "agenda"),
  WebPage(name: "PROTAGONISTI", link: BASE_URL + "protagonisti"),
  WebPage(name: "PARTNER & SPONSOR", link:  "https://www.aidp.it/portale/partner/partner-e-sponsor-app.php"),
  WebPage(name: "MAPPA", link: BASE_URL + "mappa"),
  WebPage(name: "SOSTENIBILITÀ", link: BASE_URL +"sostenibilita"),
  WebPage(name: "MOBILITÀ", link: BASE_URL + "mobilita"),
  WebPage(name: "TERRITORIO", link: BASE_URL + "territorio"),
  WebPage(name: "FUORICONGRESSO", link: BASE_URL + "fuoricongresso"),
  WebPage(name: "INFO & UTILITIES", link: BASE_URL + "info"),
  WebPage(name: "BOOK", link: BASE_URL + "book"),
  WebPage(name: "MEDIA WALL", link: BASE_URL + "media-wall"),

];

List<WebPage> bottomPages = [
  WebPage(name: "BIGLIETTO", link: BASE_URL + "area-riservata/biglietto"),
  WebPage(name: "AIDP AWARD", link: BASE_URL + "area-riservata/award"),
  WebPage(name: "LEARNING EXP", link: BASE_URL + "area-riservata/sessioni"),
  WebPage(name: "ACCOMPAGNATORI", link: BASE_URL + "area-riservata/accompagnatori"),
  WebPage(name: "RIEPILOGO DATI", link: BASE_URL + "area-riservata/riepilogo-dati"),
  WebPage(name: "FATTURAZIONE ", link: BASE_URL + "area-riservata/riepilogo-fattura"),
  WebPage(name: "PAGAMENTI  ", link: BASE_URL + "area-riservata/riepilogo-pagamenti"),

];
