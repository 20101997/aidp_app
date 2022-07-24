const BASE_URL = "https://app.congresso.aidp.it/";
const API_URL = "https://app.congresso.aidp.it/admin/ws/";

class MyApplicationUrl {
  static Uri notifications = Uri.parse(API_URL + 'lista_notifiche.php');
  static Uri news = Uri.parse(API_URL + 'getNews.php');
  static Uri advertisement = Uri.parse(API_URL + 'getAdv.php');
  static Uri token = Uri.parse(API_URL + 'register_token.php');
}
