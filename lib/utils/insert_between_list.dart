List<T> insertBetweenList<T>(List<T> original, T newItem) {
  List<T> newList = [];

  for (int i = 0; i < original.length; i++) {
    if (i == 0) {
      newList.add(original[i]);
    } else {
      newList.add(newItem);
      newList.add(original[i]);
    }
  }

  return newList;
}
