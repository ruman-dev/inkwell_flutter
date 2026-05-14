import 'package:get/get.dart';
import 'package:inkwell/features/home/data/repository/planet_repository_impl.dart';
import 'package:intl/intl.dart';

class PlanetInfoController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final title = "".obs;
  final dateStr = "".obs;
  final mediaType = "image".obs;
  final mediaUrl = "".obs;
  final explanation = "".obs;

  final _repository = PlanetRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    fetchPlanetInfo();
  }

  bool get isToday {
    final now = DateTime.now();
    return selectedDate.value.year == now.year &&
        selectedDate.value.month == now.month &&
        selectedDate.value.day == now.day;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    dateStr.value = DateFormat('yyyy-MM-dd').format(date);
    fetchPlanetInfo();
  }

  void previousDay() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
    dateStr.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    fetchPlanetInfo();
  }

  void nextDay() {
    if (!isToday) {
      selectedDate.value = selectedDate.value.add(const Duration(days: 1));
      dateStr.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
      fetchPlanetInfo();
    }
  }

  Future<void> fetchPlanetInfo() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repository.fetchPlanetInfo(date: selectedDate.value);

    result.fold(
      (planet) {
        title.value = planet.title;
        dateStr.value = DateFormat('yyyy-MM-dd').format(planet.date);
        mediaType.value = planet.mediaType;
        mediaUrl.value = planet.url;
        explanation.value = planet.explanation;
        isLoading.value = false;
      },
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
    );
  }
}
