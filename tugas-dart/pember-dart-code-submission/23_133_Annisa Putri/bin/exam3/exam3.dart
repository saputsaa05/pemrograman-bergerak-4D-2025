Set<int> uniqueElement(List<int> myList) {
  return myList.toSet();
}

  // TODO 1

  // End of TODO 1


Map<String, String> buildFutsalPlayersMap() {
  return {
    'Goalkeeper': 'Andri',
    'Anchor': 'Irfan',
    'Pivot': 'Fikri',
    'Right Flank': 'Aldi',
    'Left Flank': 'Hafid',
  };
}

  // TODO 2

  // End of TODO 2


Map<String, String> updatePivotPlayer() {
  final futsalPlayers = buildFutsalPlayersMap();
  
  // Mengubah nilai Pivot menjadi Fajar
  futsalPlayers['Pivot'] = 'Fajar';

  return futsalPlayers;
}
  // TODO 3

  // End of TODO 3
