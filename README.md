# gms2-test
Unit Testing Framework for Gamemaker Studio 2.3+

## Table of Contents

 1. [Requirements](#requirements)
 2. [Download](#download)
	 - [Local Package](#local-package)
	 - [Marketplace](#marketplace)
 3. [Maintainers & Contribution](#maintainers--contribution)
 4. [Samples](#samples)
 5. [API](#api)
	 - [Helpers](#helpers)
	 - [Matchers](#matchers)
	 - [Test Definitions](#test-definitions)
 6. [Unit Testing Resources](#unit-testing-resources)

## Requirements

|| Supported Version |
|--|--|
| Gamemaker Studio 2 | v2.3.0.x |

## Download
### Local Package

 1. Download the [exported local package](https://github.com/pmarincak/gms2-test/blob/master/export/package.gmltest.yymps)
 2. Select Tools > Import Local Package
 3. Navigate to the saved package and select import
 4. Import all resources

### Marketplace

This package is available for download on the [Gamemaker Marketplace](https://marketplace.yoyogames.com/assets/9280/gms2-test).

## Maintainers & Contribution
This package is maintained by [Paige Marincak](https://twitter.com/paigemarincak/). To contribute, please fork the repo and make pull requests.

## Samples
Samples can be viewed [here](https://github.com/pmarincak/gms2-test/tree/master/samples).

## API
### Helpers
#### gmltest_start
Start running the unit tests

    @param {Function} [on_conclude_callback] Do something once all tests complete.

#### gmltest_set_deterministic
Sets the seed to a static value or a random value. Can be toggled.

    @param {Bool} deterministic Whether to set the seed to a static value or not

### Matchers
#### gmltest_expect_eq
Expects that the actual value is equal to the expected value

    @param {*} expected
    @param {*} actual

#### gmltest_expect_false
Expects that the provided value is false

    @param {*} value

#### gmltest_expect_true
Expects that the provided value is true

    @param {*} value

#### gmltest_expect_gt
Expects that the actual value is greater than the expected value

       @param {*} expected
       @param {*} actual

#### gmltest_expect_lt
Expects that the actual value is less than the expected value

       @param {*} expected
       @param {*} actual

#### gmltest_expect_neq
Expects that the actual value is not equal to the expected value

    @param {*} expected
    @param {*} actual

#### gmltest_expect_not_null
Expects that the provided value is not null

    @param {*} value

#### gmltest_expect_null
Expects that the provided value is null

    @param {*} value

### Test Definitions
#### GMLTest_Harness
Base struct that all harnesses should extend from

    ///@description Called before the execution of the test.
	///             Use this function to setup your fixtures and parameterized tests.
	setup = function(){
		// Override this function
	}
	
	///@description Called after the execution of the test.
	///             Use this function to clean up your fixtures and parameterized tests.
	tear_down = function(){
		// Override this function
	}
#### test
Register a basic test with a name and a function to execute

    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
    @param {Bool} [is_async] Whether the test is async
#### xtest
Disable a registered basic test that has a name and a function to execute

    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
    @param {Bool} [is_async] Whether the test is async
#### test_f
Register a fixture test with a harness, name and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
    @param {Bool} [is_async] Whether the test is async

#### xtest_f
Disable a registered fixture test that has a harness, name and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {Function} fn The function to be executed
    @param {Bool} [is_async] Whether the test is async

#### test_p
Register a parameterized test with a harness, name, parameter, and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {*} param parameter to pass along to the inner function
    @param {Function} fn The function to be executed which takes one parameter
    @param {Bool} [is_async] Whether the test is async

#### xtest_p
Disable a registered parameterized test that has a harness, name, array of parameters, and a function to execute

    @param {Struct} harness The struct to use as the harness when the test executes
    @param {String} name The name of the test to be logged to the console
    @param {*} param parameter to pass along to the inner function
    @param {Function} fn The function to be executed which takes one parameter
    @param {Bool} [is_async] Whether the test is async
    
## Unit Testing Resources
The following are a list of resources that can assist you with writing your unit tests. 

- [What is unit testing?](https://en.wikipedia.org/wiki/Unit_testing)
- [What is a fixture?](https://en.wikipedia.org/wiki/Test_fixture)
- [Beginner's Guide to Unit Testing](https://www.codementor.io/@wbsimms/unit-testing-foundations-programming-beginners-du107q81d)
