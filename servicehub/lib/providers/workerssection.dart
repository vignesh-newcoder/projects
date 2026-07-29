import 'package:stop_watch_timer/stop_watch_timer.dart';

class WorkerSection {
  StopWatchTimer timer;
  DateTime? startTime;
  DateTime? stopTimer;
  double total;
  bool isRunning;
  bool isStoped;
  String modeofpayment;

  WorkerSection(
      {required this.timer,
      this.startTime,
      this.stopTimer,
      this.total = 0,
      this.isRunning = false,
      this.isStoped = false,
      this.modeofpayment = "UPI"});
}
