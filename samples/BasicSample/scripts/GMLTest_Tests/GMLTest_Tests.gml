///@description Base struct that all harnesses should extend from
function GMLTest_Harness() constructor {
	
	///@description Called before the execution of the test.
	///             Use this function to setup your fixtures and parameterized tests.
	function setup(){
		// Override this function
	}
	
	///@description Called after the execution of the test.
	///             Use this function to clean up your fixtures and parameterized tests.
	function tear_down(){
		// Override this function
	}
}

///@description Test struct used to hold the registered test data for later execution
function _GMLTest_Test() constructor {
	_name = "";
	_harness = noone;
	_fn = noone;
	_disabled = false;
	_array = noone;
	
	function get_name(){
		var result = "";
		if (_harness != noone){
			var temp = new _harness();
			result = instanceof(temp) + "::";
			delete temp;
		}
		result += _name;
		return result;
	}
}

///@description Register a basic test with a name and a function to execute
///@param {String} name The name of the test to be logged to the console
///@param {Function} fn The function to be executed
function test(name, fn){	
	_gmltest_create_manager();
	var temp = new _GMLTest_Test();
	temp._fn = fn;
	temp._name = name;
	global.GMLTestManager.add_test(temp);
	return temp;
}

///@description Disable a registered basic test that has a name and a function to execute
///@param {String} name The name of the test to be logged to the console
///@param {Function} fn The function to be executed
function xtest(name, fn){
	var temp = test(name, fn);
	temp._disabled = true;
}

///@description Register a fixture test with a harness, name and a function to execute
///@param {Struct} harness The struct to use as the harness when the test executes
///@param {String} name The name of the test to be logged to the console
///@param {Function} fn The function to be executed
function test_f(harness, name, fn){
	var temp = test(name, fn);
	temp._harness = harness;
	return temp;
}

///@description Disable a registered fixture test that has a harness, name and a function to execute
///@param {Struct} harness The struct to use as the harness when the test executes
///@param {String} name The name of the test to be logged to the console
///@param {Function} fn The function to be executed
function xtest_f(harness, name, fn){
	var temp = test_f(harness, name, fn);
	temp._disabled = true;
}

///@description Register a parameterized test with a harness, name, array of parameters, and a function to execute
///@param {Struct} harness The struct to use as the harness when the test executes
///@param {String} name The name of the test to be logged to the console
///@param {Array} array An array containing a list of parameters to be executed using the same provided function
///@param {Function} fn The function to be executed which takes one parameter
function test_p(harness, name, array, fn) {
	var temp = test_f(harness, name, fn);
	temp._array = array;
	return temp;
}

///@description Disable a registered parameterized test that has a harness, name, array of parameters, and a function to execute
///@param {Struct} harness The struct to use as the harness when the test executes
///@param {String} name The name of the test to be logged to the console
///@param {Array} array An array containing a list of parameters to be executed using the same provided function
///@param {Function} fn The function to be executed which takes one parameter
function xtest_p(harness, name, array, fn) {
	var temp = test_p(harness, name, array, fn);
	temp._disabled = true;
}