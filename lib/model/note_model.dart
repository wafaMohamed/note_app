class Note {
  int _id = 0;
  String _title = '';
  String _description = '';
  int _priority = 0;
  DateTime _dateTime = DateTime(DateTime.april);

  // constructor to help us create object
  Note(this._title, this._priority, this._dateTime, [this._description = '']);

  Note.withIDAsParameter(this._id, this._title, this._priority, this._dateTime,
      [this._description = '']);

  DateTime get dateTime => _dateTime;

  int get priority => _priority;

  String get description => _description;

  String get title => _title;

  int get id => _id;

// we don't need setter for _id, cause the db make it automatically
// set id(int value) {
//   _id = value;
// }
  set dateTime(DateTime newValue) {
    _dateTime = newValue;
  }

  set priority(int newPriority) {
    // 1..2
    if (newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    }
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set title(String newTitle) {
    // you can make some validation by if condition
    // if value.length less than or = 255 save it to database otherwise not.
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

// create a function that convert note object into map object
// because the sqlite deals with map object to saves data into db.
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['dateTime'] = _dateTime.toIso8601String(); // Convert DateTime to string
    return map;
  }

// you can do it like this also by (Alt+insert) toMap
/*  Map<String, dynamic> toMap() {
    return {
      '_id': this._id,
      '_title': this._title,
      '_description': this._description,
      '_priority': this._priority,
      '_dateTime': this._dateTime,
    };
  }*/

  // create Function to Extract a note object from map object
// because the sqlite deals with map object to retrieves data from db.
  Note.fromMapObject(Map<String, dynamic> map) {
    // make sure the keys is the same in toMap to avoid get a runtime error
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    // Convert string to DateTime
    _dateTime = DateTime.parse(map['dateTime']);
  }
}
