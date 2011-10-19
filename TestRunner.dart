/*
class FizzBuzz {
  speak(n) {
    if (n == 3) return 'Fizz';
    return n.toString();
  }
}

main() {
  var runner = new TestRunner();
  var fizzBuzz;

  runner.setUp = () => fizzBuzz = new FizzBuzz();
  runner.tearDown = () => fizzBuzz = null;

  runner.add('speak number By 1', () => Expect.equals('1', fizzBuzz.speak(1)));
  runner.add('speak number By 2', () => Expect.equals('2', fizzBuzz.speak(2)));
  runner.add('speak Fizz By 3', () => Expect.equals('Fizz', fizzBuzz.speak(3)));
  runner.add('speak Fizz By 6', () => Expect.equals('Fizz', fizzBuzz.speak(6)));

  runner.run();
}
*/

class TestRunner {
  // Set Up
  Function _setUp;
  set setUp(Function func) => _setUp = func;

  // Tear Down
  Function _tearDown;
  set tearDown(Function func) => _tearDown = func;

  // Test Cases
  Map<String, Function> tests;

  // Constructor
  TestRunner() =>
    ((){
      _setUp = null;
      _tearDown = null;
      tests = new LinkedHashMap<String, Function>();
    })();

  // Add Test Case
  add(message, test) =>
    tests[message] = test;

  // Run Test Cases
  run() =>
    ((){
      var cnt = 0;
      var failures = 0;
      var errors = 0;

      tests.forEach((message,test) {
        cnt++;
        try {
          // Run
          if (_setUp != null) _setUp();
          test();
          print('${message} : Green!');
        } catch (ExpectException e) {
          // Failure
          print('${message} : Red!');
          print('  ${e}');
          failures++;
        } catch (Exception e) {
          // Error
          print('${message} : Error!');
          print('  ${e}');
          errors++;
        } finally {
          if (_tearDown != null) _tearDown();
        }
      });
      // Print results
      print('Tests run: ${cnt}, Failures ${failures}, Errors: ${errors}');
    })();
}
