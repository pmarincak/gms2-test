///@description A custom fixture that tests MyObject
function MyFixture() : GMLTest_Harness() constructor {
	
	instance = noone;
	
	function setup(){
		// Before we execute the test let's create the instance we will be testing
		// This way we don't have to duplicate code everywhere to do our tests
		instance = instance_create_depth(0,0,0, MyObject);
	}
	
	function tear_down(){
		// After we are done testing let's clean up and destroy the instance to keep things clean
		instance_destroy(instance);
	}
	
}

///@description Fixture test showing basic usage
test_f(MyFixture, "NotVisibleByDefault", function(){
	/// The function has access to the variables declared in MyFixture
	gmltest_expect_false(instance.visible);
});

///@description Disabled fixture test showing basic usage
xtest_f(MyFixture, "NameIsHelloByDefault", function(){
	gmltest_expect_eq("hello", instance.name);
});