///@description Creates the GMLTestManager if it does not exist
///@param {Function} [on_conclude_callback] Do something once all tests are complete.
function _gmltest_create_manager() {
	var on_conclude_callback = argument_count>0 ? argument[0] : undefined;
	if (!variable_global_exists("GMLTestManager")){
		global.GMLTestManager = new GMLTest_Manager();
	}
	if(is_method(on_conclude_callback)){
		global.GMLTestManager._on_conclude = on_conclude_callback;
	}
}

///@description Throws an exception if the provided values do not match
///@param {*} expected
///@param {*} actual
///@param {Bool} matches
function _gmltest_throw_result(expected, actual, matches) {
	if (!matches){
		var errorMessage = "Expected [" + string(expected) + "] Actual [" + string(actual) + "]";
		throw({message: errorMessage, stacktrace: debug_get_callstack(), expectFailed: true});
	}
}

#region Typechecking

///@desc Checks if the provided value is an int or not
///@param {*} value The value to check
///@returns {Bool} True if int, false otherwise
function _gmltest_is_int(value) {
	if (is_undefined(value) || !is_numeric(value)){
		return false;
	}

	var remainder = value % 1;
	return remainder == 0;
}

///@desc Checks if the provided value is null or not
///@param {*} value The value to check
///@returns {Bool} True if null, false otherwise
function _gmltest_is_null(value){
	var result = is_undefined(value) || !_gmltest_is_int(value) || value == noone || value < 0 || !instance_exists(value);
	return result;
}

#endregion

#region Logging

///@description Logs the provided callstack to the console
///@param {Array} callstack
function _gmltest_log_callstack(callstack) {
	show_debug_message("Callstack:");
	show_debug_message("-------------------------");
	for (var i = 0; i < array_length(callstack); i++){
		show_debug_message(callstack[i]);
	}
}

///@description Logs the provided status for the given test name to the console
///@param {String} status
///@param {String} testName
function _gmltest_log_status(status, testName){
	show_debug_message("[" + status + "] " + testName);
}

#endregion



