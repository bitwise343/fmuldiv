// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Fmuldiv.sol";

contract FmuldivTest is DSTest {
    Fmuldiv fmuldiv;

    function setUp() public {
        fmuldiv = new Fmuldiv();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
