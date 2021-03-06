pragma experimental SMTChecker;

// 2 warnings, receive and A.g
contract A {
	uint x;

	receive () external virtual payable {
		assert(x == 1);
	}
	function g() public view {
		assert(x == 1);
	}
}

// 2 warnings, receive and A.g
contract B is A {
	uint y;

	receive () external payable override {
		assert(x == 1);
	}
}
// ----
// Warning 6328: (128-142): CHC: Assertion violation happens here.\nCounterexample:\nx = 0\n\n\n\nTransaction trace:\nA.constructor()\nState: x = 0\nA.receive()
// Warning 6328: (177-191): CHC: Assertion violation happens here.\nCounterexample:\nx = 0\n\n\n\nTransaction trace:\nA.constructor()\nState: x = 0\nA.g()
// Warning 6328: (300-314): CHC: Assertion violation happens here.\nCounterexample:\ny = 0, x = 0\n\n\n\nTransaction trace:\nB.constructor()\nState: y = 0, x = 0\nB.receive()
