import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/reminders/data/local_notification_scheduler.dart';
import 'package:garir_khata/features/reminders/domain/notification_payload.dart';
import 'package:garir_khata/features/reminders/domain/notification_scheduler.dart';
import 'package:go_router/go_router.dart';

/// Runs ReminderEngine on startup/resume and routes notification taps.
class ReminderLifecycleHost extends ConsumerStatefulWidget {
  const ReminderLifecycleHost({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<ReminderLifecycleHost> createState() =>
      _ReminderLifecycleHostState();
}

class _ReminderLifecycleHostState extends ConsumerState<ReminderLifecycleHost>
    with WidgetsBindingObserver {
  bool _started = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _evaluate();
    }
  }

  Future<void> _bootstrap() async {
    if (_started) {
      return;
    }
    _started = true;
    LocalNotificationScheduler.globalOnTap = _routePayload;
    final NotificationScheduler scheduler =
        ref.read(notificationSchedulerProvider);
    if (scheduler is LocalNotificationScheduler) {
      await scheduler.initialize();
      await scheduler.requestPermission();
      final String? payload = await scheduler.consumeLaunchPayload();
      _routePayload(payload);
    }
    await _evaluate();
  }

  Future<void> _evaluate() async {
    await ref.read(reminderEngineProvider).evaluateAll();
    ref.invalidate(selectedVehicleRemindersProvider);
    ref.invalidate(upcomingDashboardRemindersProvider);
  }

  void _routePayload(String? raw) {
    final ReminderNotificationPayload? payload =
        ReminderNotificationPayload.tryParse(raw);
    if (payload == null || !mounted) {
      return;
    }
    context.push(payload.deepLinkPath());
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
