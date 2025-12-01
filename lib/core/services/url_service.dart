
class UrlService {

  static getCurrentUrl() {
    var path = Uri.base.path;
    return path.replaceAll('web_doopos/web/', '');
  }
}
