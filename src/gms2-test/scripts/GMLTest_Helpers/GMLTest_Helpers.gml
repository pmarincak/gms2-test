///@description Start running the unit tests
///@param {Function} [on_conclude_callback] Do something once all tests complete.
function gmltest_start(on_conclude_callback) {
	_gmltest_create_manager(on_conclude_callback);
	global.GMLTestManager.execute();
}

///@description Sets the seed to a static value or a random value. Can be toggled.
///@param {Bool} deterministic Whether to set the seed to a static value or not
function gmltest_set_deterministic(deterministic) {
	if (deterministic){
		random_set_seed(0);
	}
	else{
		random_set_seed(global.GMLTestManager._seed);
	}
}