// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Fmuldiv.sol";

contract FmuldivTest is DSTest {
    Fmuldiv fmuldiv;

    function setUp() public {
        fmuldiv = new Fmuldiv();
    }

    function testFMul() public {
        assertEq(fmuldiv.fmul(2.5e27, 0.5e27, 1e27), 1.25e27);
        assertEq(fmuldiv.fmul(2.5e18, 0.5e18, 1e18), 1.25e18);
        assertEq(fmuldiv.fmul(2.5e8, 0.5e8, 1e8), 1.25e8);
    }

    function testFDiv() public {
        assertEq(fmuldiv.fdiv(1e27, 2e27, 1e27), 0.5e27);
        assertEq(fmuldiv.fdiv(1e18, 2e18, 1e18), 0.5e18);
        assertEq(fmuldiv.fdiv(1e8, 2e8, 1e8), 0.5e8);
    }
}
