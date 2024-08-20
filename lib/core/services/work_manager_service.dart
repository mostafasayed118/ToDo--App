import 'package:todo_app/core/services/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    await Workmanager().registerPeriodicTask(
      'id1',
      'Show Notification',
      frequency: const Duration(minutes: 15),
    );
  }

  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);

    registerMyTask();
  }

  void cancelMyTask() async {
    await Workmanager().cancelByUniqueName('id1');
  }
}

@pragma('vm:entry-point')
void actionTask() {
  //! Show Notification
  Workmanager().executeTask((task, inputData) async {
    LocalNotificationService.showDailyScheduledNotification();

    return Future.value(true);
  });
}

// 1 scheduled notification at 9 pm
// 2 executed for this notification
