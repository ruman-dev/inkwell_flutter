import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlanetInfoController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  /// Mock API Data
  final title = "Messier Catalog at Uniform Scale".obs;
  final dateStr = "2026-05-14".obs;
  final mediaType = "image".obs;
  final mediaUrl =
      "https://apod.nasa.gov/apod/image/2605/messier_portrait_100px_160h.jpg"
          .obs;
  final explanation =
      "What are some of the most interesting astronomical objects you can see in the night sky? Armed with a good pair of binoculars or a small telescope..."
          .obs;

  bool get isToday {
    final now = DateTime.now();
    return selectedDate.value.year == now.year &&
        selectedDate.value.month == now.month &&
        selectedDate.value.day == now.day;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    // Format date for the UI
    dateStr.value = DateFormat('yyyy-MM-dd').format(date);
  }

  void previousDay() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
    dateStr.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  void nextDay() {
    if (!isToday) {
      selectedDate.value = selectedDate.value.add(const Duration(days: 1));
      dateStr.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }
}
