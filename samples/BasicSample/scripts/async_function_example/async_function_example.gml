///@description A mock up async function that passes the result to the callback function
///@param {Func} _callback callback function to execute when the async operation completes. Takes the result of the async function as the input
///@param {String} [res="async_completed"] Pass a different string to overwrite the default result of the async function
function async_function_example(_callback){
	var async_handle = instance_create_depth(0,0, 0, o_async);
	with async_handle{
		callback = _callback;
		if argument_count > 1{
			res = string(argument[1]);
		}
	}
	return async_handle;
}