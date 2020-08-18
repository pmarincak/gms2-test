///@description Struct used to manage and execute all registered tests
function GMLTest_Manager() constructor {
	_tests = [];
	_failCount = 0;
	_disabledCount = 0;
	_testCount = 0;
	_seed = random_get_seed();
	
	///@description Get the status string for whether there was a pass or a fail
	///@param {Bool} passed
	_get_status_string = function(passed){
		return passed ? "PASSED" : "FAILED";
	}
	
	///@description Run a standard test
	///@param {Struct} test
	_run_test = function (test){
		var passed = true;
		var testName = test.get_name();
		_gmltest_log_status("RUN", testName);
		_testCount++;
		
		try {
			test._fn();
		} catch (e){
			passed = false;
			_handleException(e);
		}
		
		var statusString = _get_status_string(passed);
		_gmltest_log_status(statusString, testName);
	}
	
	///@description Run a fixture test
	///@param {Struct} test
	_run_fixture_test = function (test){
		var passed = true;
		var testName = test.get_name();
		_gmltest_log_status("RUN", testName);
		_testCount++;
		
		var harness = new test._harness();
		harness.setup();
		var fn = method(harness, test._fn);
		try {
			fn();
		} catch (e){
			passed = false;
			_handleException(e);
		}
		harness.tear_down();
		delete harness;
		
		var statusString = _get_status_string(passed);
		_gmltest_log_status(statusString, testName);
	}
	
	///@description Run a parameterized test
	///@param {Struct} test
	_run_parameter_test = function (test){
		for (var i = 0; i < array_length(test._array); i++){
			var passed = true;
			var testName = test.get_name() + "::" + string(i);
			_gmltest_log_status("RUN", testName);
			_testCount++;
			
			var harness = new test._harness();
			harness.setup();
			var fn = method(harness, test._fn);
			try {
				fn(test._array[i]);
			} catch (e){
				passed = false;
				_handleException(e);
			}
			harness.tear_down();
			delete harness;
				
			var statusString = _get_status_string(passed);
			_gmltest_log_status(statusString, testName);
		}
	}
	
	///@description Handles any exceptions thrown during the execution of the test
	///@param {Struct} e
	_handleException = function (e){
		_failCount++;
		show_debug_message(e.message);
		// If we threw an exception and it wasn't because an expect failed, we should log the callstack to the user
		if (!variable_struct_exists(e, "expectFailed")){
			_gmltest_log_callstack(e.stacktrace);
		}
	}
	
	///@description Execute the provided test struct
	///@param {Struct} test
	_execute_test = function (test) {
		if (test._disabled){
			_disabledCount++;
			_gmltest_log_status("DISABLED", test.get_name());
			return;
		}
		
		if (test._harness == noone){
			_run_test(test);
		}else if (test._array == noone){
			_run_fixture_test(test);
		}
		else {
			_run_parameter_test(test);
		}
	}
	
	///@description Execute all registered tests
	execute = function () {
		var testCount = array_length(_tests);
		var startTime = current_time;
		
		for (var i = 0; i < testCount; i++){
			var test = _tests[i];
			_execute_test(test);
		}
		
		var endTime = current_time;
		var timeToRun = endTime - startTime;
		
		show_debug_message("-------------------------");
		show_debug_message("RAN " + string(_testCount) + " TESTS IN " + string(timeToRun) + "MS.");
		if (_disabledCount > 0){
			show_debug_message("DISABLED TESTS: " + string(_disabledCount));
		}
		if (_failCount > 0){
			show_debug_message("FAILED TESTS: " + string(_failCount));
		}
	}
	
	///@description Adds a test to this manager
	///@param {Struct} test
	add_test = function(test){
		array_set(_tests, array_length(_tests), test);
	}
}