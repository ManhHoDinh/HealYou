import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class ImageFinder {
  static Future<String> getImagesLinks(String searchTerm) async {
    try {
      String searchUrl =
          "https://www.google.com/search?q=$searchTerm&site=webhp&tbm=isch";
      http.Response response = await http.get(Uri.parse(searchUrl));
      String responseBody = response.body;
      var document = parse(responseBody);

      List<Element> imgTags = document.getElementsByTagName('img');

      List<String> imgUrls = [];
      for (var img in imgTags) {
        if (img.attributes['src']!.startsWith("http")) {
          imgUrls.add(img.attributes['src']!);
        }
      }

      return imgUrls.isNotEmpty ? imgUrls[0] : 'Not found link';
    } catch (e) {
      return 'Not found link';
    }
  }
}
