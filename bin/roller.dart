
var die = List<int>.generate(10, (i) => i + 1);
var rolled = [];
var fail = [];
var success = [];
Future<String> oWoD(String total, String dc, String roller) async {
  var total1 = int.parse(total);
  var dc1 = int.parse(dc);
  rolled = [];
  fail = [];
  success = [];
  for (var i = 0; i < total1-1; i++) {
    var randomItem = (die.toList()..shuffle()).first;
    rolled.add(randomItem);
  }

  for (var i = 0; i < rolled.length; i++) {
    if (rolled[i] < dc1) {
      fail.add(rolled[i]);
    } else if (rolled[i] >= dc1 ) {
      success.add(rolled[i]);
    }
  }
  
  fail.forEach((element) {
    if (element == 1) {
      success.forEach((element) {
        if (element == 10) {
          success.remove(element);
          element = 0;
          fail.add(element);
        }
      });
    }
  });
  return '${roller}, rolled ${fail.length.toString()} failures, and ${success.length.toString()} successes, Actual rolls: ${fail.toString()}, ${success.toString()}';
}