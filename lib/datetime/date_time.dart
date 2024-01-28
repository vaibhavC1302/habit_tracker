String todaysDateFormatted() {
  var dateTimeObject = DateTime.now();

  //year in the yyyy format
  String year = dateTimeObject.year.toString();

  // month in mm format
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in dd format
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
