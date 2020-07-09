///@description Start running the unit tests
function gmltest_start() {
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