void main() {
  // 1
  print("First main Thread");
  // 3 in the runtime it will perform in the end.
  printContent();
  thenPrintContent();
  // 2
  print("End main Thread");
}

// Dart-Flutter => Single Threaded so to implement asynchronous programming we use (Future, async , await, then)
// 1- heavy-long operation to download content
Future<String> downloadContent() {
  Future<String> result = Future.delayed(
    const Duration(seconds: 3),
    () => '3 sec to download the content...',
  );
  return result;
}

//2 print future func
printContent() async {
  // why not Future<String>, since you will get the value which is String
  // if you put it as Future<String> you will not get the value  => The content is: Instance of 'Future<String>'
  String printContentFunc = await downloadContent();
  print('The content is: $printContentFunc');
}

//3- use .then function instead of async and await:
thenPrintContent() {
  Future<String> thenPrintContentFunc = downloadContent();
  thenPrintContentFunc.then(
    (value) => print('The content with .then func: $value'),
  );
}
