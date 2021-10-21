// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

interface Fmuldiv {
    function fmul(uint256 x, uint256 y, uint256 b) external returns (uint z);
    function fdiv(uint256 x, uint256 y, uint256 b) external returns (uint z);
}

contract FmuldivTest is DSTest {
    Fmuldiv fmuldiv;

    function setUp() public {
        address _fmuldiv;
        assembly {
            let ptr := mload(0x40)
            mstore(           ptr, 0x60e561000e60003960e56000f3fe7c0100000000000000000000000000000000)
            mstore(add(ptr, 0x20), 0x0000000000000000000000006000350463769f5b03811415604b57604a603660)
            mstore(add(ptr, 0x40), 0x02607a565b603e6001607a565b60466000607a565b609c565b5b6336d33f6781)
            mstore(add(ptr, 0x60), 0x1415607557607460606002607a565b60686001607a565b60706000607a565b60)
            mstore(add(ptr, 0x80), 0xbb565b5b600080fd5b60006020820260040160208101361015609257600080fd)
            mstore(add(ptr, 0xa0), 0x5b8035915050919050565b828282586014018282029283048214905760006000)
            mstore(add(ptr, 0xc0), 0x52fd5b5004505050565b82828291909158601301828202918204831490576000)
            mstore(add(ptr, 0xe0), 0x6000fd5b90500460005260206000f35050505600000000000000000000000000)
            _fmuldiv := create(0, ptr, 0x100)
        }
        fmuldiv = Fmuldiv(_fmuldiv);
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

// 60e561000e60003960e56000f3fe7c0100000000000000000000000000000000
// 0000000000000000000000006000350463769f5b03811415604b57604a603660
// 02607a565b603e6001607a565b60466000607a565b609c565b5b6336d33f6781
// 1415607557607460606002607a565b60686001607a565b60706000607a565b60
// bb565b5b600080fd5b60006020820260040160208101361015609257600080fd
// 5b8035915050919050565b828282586014018282029283048214905760006000
// 52fd5b5004505050565b82828291909158601301828202918204831490576000
// 6000fd5b90500460005260206000f350505056
