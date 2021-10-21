object "Fmuldiv" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            let s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)

            if eq(s, 0x769f5b03) /* fmul(uint256,uint256,uint256) */ {
                fmul(decodeUint(0), decodeUint(1), decodeUint(2))
            }

            if eq(s, 0x36d33f67) /* fdiv(uint256,uint256,uint256) */ {
                fdiv(decodeUint(0), decodeUint(1), decodeUint(2))
            }

            /* if we reach here, revert on account of incorrect selector */
            revert(0, 0)

            function decodeUint(offset) -> v {
                let pos := add(4, mul(offset, 0x20))
                if lt(calldatasize(), add(pos, 0x20)) {
                    revert(0, 0)
                }
                v := calldataload(pos)
            }

            function fmul(x, y, baseUnit) {
                verbatim_3i_0o(hex"58601401828202928304821490576000600052fd5b500460005260206000f3", x, y, baseUnit)
            }

            function fdiv(x, y, baseUnit) {
                verbatim_3i_0o(hex"919091586013018282029182048314905760006000fd5b90500460005260206000f3", x, y, baseUnit)
            }

        }
    }
}
