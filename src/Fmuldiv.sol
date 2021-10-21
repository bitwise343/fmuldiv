// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

contract Fmuldiv {

    function fmul(
        uint256 x,
        uint256 y,
        uint256 baseUnit
    ) public pure returns (uint256 z) {
        assembly {
            let a := mul(x, y)
            if iszero(eq(div(a, x), y)) { revert(0, 0) }
            z := div(a, baseUnit)
        }
    }

    function fdiv(
        uint256 x,
        uint256 y,
        uint256 baseUnit
    ) public pure returns (uint256 z) {
        assembly {
            let a := mul(x, baseUnit)
            if iszero(eq(div(a, x), baseUnit)) { revert(0, 0) }
            z := div(a, y)
        }
    }
}
