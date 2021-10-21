# fmuldiv
I wanted to try writing the fixed point math algos for multiplication and division in pure assembly, then call them from within solidity. The assembly seems to work, but calling them in Yul does not.

## easm
Ethereum assembly files live within [easm](/easm). You can run these files using geth's `evm` command, but you need to uncomment the three push instructions at the top (to feed the assembly some input values on the stack).
```sh
$ evm run easm/fmul.easm
```
```sh
$ evm run easm/fdiv.easm
```
