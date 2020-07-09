///@description Standard test showing basic usage
test("Basic Standard Test", function(){
	gmltest_expect_true(true);
});

///@description Standard disabled test showing basic usage
///             If this test was run this would cause a failure, but it won't because it is disabled
xtest("Basic Disabled Test", function(){
	gmltest_expect_true(false); 
});