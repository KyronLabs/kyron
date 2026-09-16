// lib/utils/deferred_rebuild.dart
import 'package:flutter/scheduler.dart';

/// Runs [action] now, unless a frame is being built -- in which case it runs
/// once that frame is done.
///
/// For a callback that ends in setState and can be reached from inside a
/// build. Opening a clip full screen takes a decoder off one in the feed, and
/// the feed tile is told so from inside the viewer's initState: calling
/// setState there throws, and the throw was reported as the clip failing to
/// open rather than as what it was.
void whenNotBuilding(VoidCallback action) {
  final phase = SchedulerBinding.instance.schedulerPhase;
  final building = phase == SchedulerPhase.persistentCallbacks ||
      phase == SchedulerPhase.midFrameMicrotasks;

  if (building) {
    SchedulerBinding.instance.addPostFrameCallback((_) => action());
  } else {
    action();
  }
}
