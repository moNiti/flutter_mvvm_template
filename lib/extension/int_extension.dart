Future<dynamic> wait(Duration d) async {
  await Future.delayed(d);
}

extension Wait on int {
  Future<void> get seconds => wait(Duration(seconds: this));
  Future<void> get minutes => wait(Duration(minutes: this));
  Future<void> get milliseconds => wait(Duration(milliseconds: this));
}
