void filterAndStoreByCategory({
  required List inputList,
  required String category,
  required List outputList,
}) {
  outputList.clear();
  outputList.addAll(inputList.where((item) => item['category'] == category));
}
