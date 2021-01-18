///@description Standard test showing basic usage
test("Basic Standard Test", function(){
	gmltest_expect_true(true);
});

///@description Standard disabled test showing basic usage
///             If this test was run this would cause a failure, but it won't because it is disabled
xtest("Basic Disabled Test", function(){
	gmltest_expect_true(false); 
});

///@description Standard async test showing basic usage
test("Basic Standard Test with Async funcitons", function(_done){
	self.done = _done;
	var callback = method(self, function(res){show_debug_message(res); done()})
	async_function_example(callback);
}, true)

///@description Standard async test showing basic usage where the async result can trigger a test to fail
test("Basic Standard Test with Async funcitons whose result should cause the test to fail", function(_done){
	self.done = _done;
	var callback = method(
		self,
		function(res){
			// res should be a string
			try{
				gmltest_expect_true(is_real(res));
			}
			catch(err){
				done(err);
			}
		}
	);
	async_function_example(callback);
}, true)

