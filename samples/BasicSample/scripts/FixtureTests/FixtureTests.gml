///@description A custom fixture that tests MyObject
function MyFixture() : GMLTest_Harness() constructor {
	
	instance = noone;
	
	setup = function(){
		// Before we execute the test let's create the instance we will be testing
		// This way we don't have to duplicate code everywhere to do our tests
		instance = instance_create_depth(0,0,0, MyObject);
	}
	
	tear_down = function() {
		// After we are done testing let's clean up and destroy the instance to keep things clean
		instance_destroy(instance);
	}
	
}

///@description Fixture test showing basic usage
test_f(MyFixture, "NotVisibleByDefault", function(){
	/// The function has access to the variables declared in MyFixture
	gmltest_expect_eq(false, instance.visible);
});

///@description Fixture test showing basic usage with async functions
test_f(MyFixture, "Async Test NameIsHelloByDefault", function(_done){
	self.done = _done;
	// In order for the callback function to have access to the variables declared in MyFixture, we need to expose the current context
	// to it before passing it to the async function
	var callback = method(self, function(res){
			show_debug_message(res); 
			done();
			gmltest_expect_eq("hello", instance.name);
	})
	async_function_example(callback);
}, true);

///@description Disabled fixture test showing basic usage
xtest_f(MyFixture, "NameIsHelloByDefault", function(){
	gmltest_expect_eq("hello", instance.name);
});