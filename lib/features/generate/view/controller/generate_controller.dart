
import 'package:scanify/core/enum/tool_data_types.dart';

class GenerateScreenController {
  List<PopularType> get popularOnly => PopularType.values;
  List<SocialType> get socialOnly => SocialType.values;
  List<BarcodeToolType> get barcodeOnly => BarcodeToolType.values;
}