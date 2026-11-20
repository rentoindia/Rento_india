/// Small helpers so screens never crash on a missing / differently typed JSON field.
double dbl(dynamic v, [double fallback = 0]) {
  if (v == null) return fallback;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString().replaceAll(RegExp(r'[^0-9.\-]'), '')) ??
      fallback;
}

int intv(dynamic v, [int fallback = 0]) => dbl(v, fallback.toDouble()).round();

String str(dynamic v, [String fallback = '']) =>
    v == null ? fallback : v.toString();

String? strOrNull(dynamic v) {
  if (v == null) return null;
  final s = v.toString();
  return s.isEmpty ? null : s;
}

bool boolv(dynamic v, [bool fallback = false]) {
  if (v == null) return fallback;
  if (v is bool) return v;
  return v.toString().toLowerCase() == 'true';
}

/// Parses an ISO date string from the server into the phone's local time.
DateTime? date(dynamic v) {
  if (v == null) return null;
  return DateTime.tryParse(v.toString())?.toLocal();
}

/// Date -> UTC ISO string that the backend understands.
String? isoUtc(DateTime? d) => d?.toUtc().toIso8601String();

Map<String, dynamic> asMap(dynamic v) {
  if (v is Map) return v.map((k, val) => MapEntry(k.toString(), val));
  return <String, dynamic>{};
}

List<Map<String, dynamic>> asMaps(dynamic v) {
  if (v is List) return v.whereType<Map>().map(asMap).toList();
  return <Map<String, dynamic>>[];
}

List<String> asStrings(dynamic v) {
  if (v is List)
    return v.where((e) => e != null).map((e) => e.toString()).toList();
  return <String>[];
}
