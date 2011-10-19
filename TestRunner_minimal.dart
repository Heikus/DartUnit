class TestRunner{Function _setUp;set setUp(Function func)=>_setUp=func;Function _tearDown;set tearDown(Function func)=>_tearDown=func;Map<String,Function> tests;TestRunner()=>((){_setUp=null;_tearDown=null;tests=new LinkedHashMap<String,Function>();})();add(message,test)=>tests[message]=test;run()=>((){var cnt=0;var failures=0;var errors=0;tests.forEach((message,test){cnt++;try{if(_setUp!=null)_setUp();test();print('${message} : Green!');}catch(ExpectException e){print('${message} : Red!');print('  ${e}');failures++;}catch(Exception e){print('${message} : Error!');print('  ${e}');errors++;}finally{if(_tearDown!=null)_tearDown();}});print('Tests run: ${cnt}, Failures ${failures}, Errors: ${errors}');})();}