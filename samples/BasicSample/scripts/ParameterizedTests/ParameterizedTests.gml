///@description Parameterized test showing basic usage
///             We don't need any custom setup so we will use the basic harness
test_p(GMLTest_Harness, "IsNumericTest", [1, 2, -1, 0], function(p){
	// The value of p is equal to 1, 2, -1, or 0
	// This function will be called each time for each value to test the values
	gmltest_expect_true(is_numeric(p));
});

///@description Disabled parameterized test showing basic usage
///             If this test was run this would cause a failure, but it won't because it is disabled
xtest_p(GMLTest_Harness, "IsUndefinedTest",[undefined, noone, "hello"], function(p){
	gmltest_expect_eq(undefined, p);
});