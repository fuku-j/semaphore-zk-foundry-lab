// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "../contracts/Poseidon/Counter.sol";

/**
 * @dev CounterScript is deploy Counter.sol to EVM.
 */
contract CounterScript is Script {
    Counter counter;
    uint256 _zeroValue;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new Counter(_zeroValue);

        vm.stopBroadcast();
    }
}
