import 'package:get/get.dart';

class HoverController extends GetxController {
  var isAnyButtonHovered = false.obs;
  var hoveredButtons = [].obs;

  void setHoverState(bool isHovered) {
    isAnyButtonHovered.value = isHovered;
  }

  void addHovered() {
    hoveredButtons.add(true);
  }

  void removeHovered() {
    hoveredButtons.removeLast();
  }
}
