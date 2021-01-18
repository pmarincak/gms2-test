///@description Parameterized test showing basic usage
///             We don't need any custom setup so we will use the basic harness
test_p(GMLTest_Harness, "IsNumericTest", 1, function(p){
	gmltest_expect_true(is_numeric(p));
});	

///@description Parameterized test showing how we can test an array of parameters
var param_array = [1, 2, -1, 0];
for (var i = 0; i < array_length(param_array); i++){
	var _param = param_array[i];
	test_p(GMLTest_Harness, "IsNumericTest", _param, function(p){
		// The value of p is equal to 1, 2, -1, or 0
		// This function will be called each time for each value to test the values
		gmltest_expect_true(is_numeric(p));
	});	
}

///@description Parameterized test showing async function usage
test_p(GMLTest_Harness, "Async IsNumericTest",  "Parameter is passed to the callback", function(p, _done){
	self.done = _done;
	var callback = method(self, function(res){
		gmltest_expect_eq(res, "Parameter is passed to the callback");
		done();
	})
	async_function_example(callback, p);
}, true);

///@description Disabled parameterized test showing basic usage
///             If this test was run this would cause a failure, but it won't because it is disabled
xtest_p(GMLTest_Harness, "IsUndefinedTest", 1, function(p){
	gmltest_expect_eq(undefined, p);
});
