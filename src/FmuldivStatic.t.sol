// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";


contract FmuldivTest is DSTest {
    address fmul;
    address fdiv;

    function setUp() public {
        address _fmul;
        assembly {
            let ptr := mload(0x40)
            mstore(0x40, add(ptr, 0x80))
            mstore(           ptr, 0x7f604035602035600035586013018282029283048214905760006000fd5b5004)
            mstore(add(ptr, 0x20), 0x606000527e5260206000f3000000000000000000000000000000000000000000)
            mstore(add(ptr, 0x40), 0x0000000060205260406000f30000000000000000000000000000000000000000)
            _fmul := create(0, ptr, 0x80)
        }
        fmul = _fmul;
        address _fdiv;
        assembly {
            let ptr := mload(0x40)
            mstore(0x40, add(ptr, 0x80))
            mstore(           ptr, 0x7f604035602035600035919091586013018282029182048314905760006000fd)
            mstore(add(ptr, 0x20), 0x5b6000527f90500460005260206000f300000000000000000000000000000000)
            mstore(add(ptr, 0x40), 0x000000000060205260406000f300000000000000000000000000000000000000)
            _fdiv := create(0, ptr, 0x80)
        }
        fdiv = _fdiv;
    }

    function testFMul() public {
        uint result1;
        uint result2;
        uint result3;
        (bool s1, bytes memory r1) = fmul.staticcall(abi.encode(0.5e27, 2.5e27, 1e27));
        assembly { result1 := mload(add(r1, 32)) }
        (bool s2, bytes memory r2) = fmul.staticcall(abi.encode(0.5e18, 2.5e18, 1e18));
        assembly { result2 := mload(add(r2, 32)) }
        (bool s3, bytes memory r3) = fmul.staticcall(abi.encode(0.5e8, 2.5e8, 1e8));
        assembly { result3 := mload(add(r3, 32)) }
        assertEq(result1, 1.25e27);
        assertEq(result2, 1.25e18);
        assertEq(result3, 1.25e8);
    }

    function testFDiv() public {
        uint result1;
        uint result2;
        uint result3;
        (bool s1, bytes memory r1) = fdiv.staticcall(abi.encode(1e27, 2e27, 1e27));
        assembly { result1 := mload(add(r1, 32)) }
        (bool s2, bytes memory r2) = fdiv.staticcall(abi.encode(1e18, 2e18, 1e18));
        assembly { result2 := mload(add(r2, 32)) }
        (bool s3, bytes memory r3) = fdiv.staticcall(abi.encode(1e8, 2e8, 1e8));
        assembly { result3 := mload(add(r3, 32)) }
        assertEq(result1, 0.5e27);
        assertEq(result2, 0.5e18);
        assertEq(result3, 0.5e8);
    }
}


// fmul constructor
// 0x7f604035602035600035586013018282029283048214905760006000fd5b5004
// 0x606000527e5260206000f3000000000000000000000000000000000000000000
// 0x0000000060205260406000f30000000000000000000000000000000000000000

// fdiv constructor
// 0x7f604035602035600035919091586013018282029182048314905760006000fd
// 0x5b6000527f90500460005260206000f300000000000000000000000000000000
// 0x000000000060205260406000f300000000000000000000000000000000000000
