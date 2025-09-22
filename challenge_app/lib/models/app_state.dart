class AppState {
  final bool showPrimeNotification;
  final int? lastPrimeNumber;
  final DateTime? lastPrimeTime;
  final bool isApiCallActive;
  final String? timeSinceLastPrime;

  const AppState({
    this.showPrimeNotification = false,
    this.lastPrimeNumber,
    this.lastPrimeTime,
    this.isApiCallActive = false,
    this.timeSinceLastPrime
  });

  AppState copyWith({
    bool? showPrimeNotification,
    int? lastPrimeNumber,
    DateTime? lastPrimeTime,
    bool? isApiCallActive,
    String? timeSinceLastPrime
  }) {
    return AppState(
      showPrimeNotification: showPrimeNotification ?? this.showPrimeNotification,
      lastPrimeNumber: lastPrimeNumber ?? this.lastPrimeNumber,
      lastPrimeTime: lastPrimeTime ?? this.lastPrimeTime,
      isApiCallActive: isApiCallActive ?? this.isApiCallActive,
      timeSinceLastPrime: timeSinceLastPrime ?? this.timeSinceLastPrime
    );
  }
}