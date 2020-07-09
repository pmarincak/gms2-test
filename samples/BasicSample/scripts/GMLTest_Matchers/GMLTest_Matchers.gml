///@description Expects that the actual value is equal to the expected value
///@param {*} expected
///@param {*} actual
function gmltest_expect_eq(expected, actual) {
	_gmltest_throw_result(expected, actual, expected == actual);
}

///@description Expects that the provided value is false
///@param {*} value
function gmltest_expect_false(value) {
	gmltest_expect_eq(false, value);
}

///@description Expects that the provided value is true
///@param {*} value
function gmltest_expect_true(value) {
	gmltest_expect_eq(true, value);
}

///@description Expects that the actual value is greater than the expected value
///@param {*} expected
///@param {*} actual
function gmltest_expect_gt(expected, actual) {
	_gmltest_throw_result(expected, actual, expected < actual);
}

///@description Expects that the actual value is less than the expected value
///@param {*} expected
///@param {*} actual
function gmltest_expect_lt(expected, actual) {
	_gmltest_throw_result(expected, actual, expected > actual);
}

///@description Expects that the actual value is not equal to the expected value
///@param {*} expected
///@param {*} actual
function gmltest_expect_neq(expected, actual) {
	_gmltest_throw_result(expected, actual, expected != actual);
}

///@description Expects that the provided value is not null
///@param {*} value
function gmltest_expect_not_null(value) {
	_gmltest_throw_result("not null", value, !_gmltest_is_null(value));
}

///@description Expects that the provided value is null
///@param {*} value
function gmltest_expect_null(value) {
	_gmltest_throw_result("null", value, _gmltest_is_null(value));
}