import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(dynamic timestamp) {
  if (timestamp == null) return 'Invalid Date';

  DateTime dateTime;
  
  // Convert Firebase Timestamp to DateTime
  if (timestamp is Timestamp) {
    dateTime = timestamp.toDate();
  } else if (timestamp is int) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else {
    return 'Invalid Date';
  }

  // Format DateTime
  return DateFormat('h:mm a dd MMM yy').format(dateTime);
}
