///@description Struct used to manage and execute all registered tests
function GMLTest_Manager() constructor {
	_tests = [];
	_failCount = 0;
	_disabledCount = 0;
	_testCount = 0;
	_seed = random_get_seed();
	_startTime=0;
	_on_conclude=undefined; // Callback function for when all tests have concluded.
	
	///@description Get the status string for whether there was a pass or a fail
	///@param {Bool} passed
	_get_status_string = function(passed){
		return passed ? "PASSED" : "FAILED";
	}
	
	///@description Run test
	///@param {Struct} test
	_run_test = function (test){
		var testName = test.get_name();
		_gmltest_log_status("RUN", testName);
		_testCount++;
		
		if (test._harness != noone){
			// If harness is set, instantiate it, call setup(), and expose its context to _fn
			test._harness_instance = new test._harness();
			test._harness_instance.setup();
			test._fn = method(test._harness_instance, test._fn);
		}
		
		try {
			if(test._is_async){
				//_fn is async, so we should pass done as a callback to it
				if test._param  == noone{
					test._fn(test.done); 
				}
				else{
					// If param is set, pass param as the first argument
					test._fn(test._param, test.done);
				}
			}
			else{
				//_fn is sync, so we just call done afterwards
				if test._param  == noone{
					test._fn(); 
				}
				else{
					// If param is set, pass param as the first argument
					test._fn(test._param);
				}
				test.done();
			}
		} catch (e){
			// catches error if _fn's excution failed
			test.done(e) 
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
	///@param {Integer} test_index
	_execute_test_at_index = function (_test_index) {
		if(_test_index==array_length(_tests)){
			// Then we have completed all tests
			return _conclude_tests();
		}
		var test = _tests[_test_index];
		if (test._disabled){
			_disabledCount++;
			_gmltest_log_status("DISABLED", test.get_name());
			return _execute_test_at_index(_test_index+1);
		}
		
		_run_test(test);
	}
	
	///@description Execute all registered tests
	execute = function () {
		_startTime = current_time;
		_execute_test_at_index(0);
	}
	
	///@description Once all tests have passed, failed, or timed out, call this function.
	_conclude_tests = function() {
		var endTime = current_time;
		var timeToRun = endTime - _startTime;
		
		show_debug_message("-------------------------");
		show_debug_message("RAN " + string(_testCount) + " TESTS IN " + string(timeToRun) + "MS.");
		if (_disabledCount > 0){
			show_debug_message("DISABLED TESTS: " + string(_disabledCount));
		}
		if (_failCount > 0){
			show_debug_message("FAILED TESTS: " + string(_failCount));
		}
		if(is_method(_on_conclude)){
			_on_conclude();
		}
	}
	
	///@description Adds a test to this manager
	///@param {Struct} test
	add_test = function(test){
		array_push(_tests, test);
		test._index = array_length(_tests)-1;
	}
}