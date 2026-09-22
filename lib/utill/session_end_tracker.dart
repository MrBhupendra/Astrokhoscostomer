/// Remembers consultation sessions (chat / voice / video) that have just been
/// ended on this device.
///
/// Neither app calls a REST endpoint to close a session: hang-up only flips
/// `chatEnd` in Firebase Realtime Database and the backend closes the order a
/// moment later. The dashboard API is fetched as soon as we land back on the
/// home screen, so it can still report the finished session as
/// `in_progress_order.status == 1` and the home screen keeps showing the
/// "resume" card until the user pulls to refresh.
///
/// Sessions registered here are treated as finished, so a stale
/// `in_progress_order` for the same `uniqeid` is ignored until the backend
/// catches up.
class SessionEndTracker {
  SessionEndTracker._();

  /// Long enough to cover the backend catching up, short enough that a session
  /// id can never be suppressed for a genuinely new consultation.
  static const Duration _ttl = Duration(minutes: 5);

  static final Map<String, DateTime> _endedAt = {};

  static void markEnded(String? uniqeid) {
    final id = uniqeid?.trim();
    if (id == null || id.isEmpty || id == 'null') return;
    _prune();
    _endedAt[id] = DateTime.now();
  }

  static bool isEnded(String? uniqeid) {
    final id = uniqeid?.trim();
    if (id == null || id.isEmpty || id == 'null') return false;
    _prune();
    return _endedAt.containsKey(id);
  }

  /// Called once the backend agrees the session is over, so the id stops being
  /// suppressed.
  static void clear(String? uniqeid) {
    final id = uniqeid?.trim();
    if (id == null || id.isEmpty) return;
    _endedAt.remove(id);
  }

  static void clearAll() => _endedAt.clear();

  static void _prune() {
    final now = DateTime.now();
    _endedAt.removeWhere((_, at) => now.difference(at) > _ttl);
  }
}
