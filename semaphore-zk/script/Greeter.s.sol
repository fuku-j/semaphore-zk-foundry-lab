// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "../contracts/Greeter.sol";

import "../node_modules/@semaphore-protocol/contracts/Semaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/verifiers/Verifier20.sol";

/**
 * @dev CounterScript is deploy Greeter.sol to EVM.
 */
contract GreeterScript is Script {
    Greeter greeter;

    Semaphore semaphore;
    address semaphoreAddress;
    uint256 zeroValue;

    Verifier20 verifier;
    address verifierAddress;

    ISemaphore.Verifier iVerifier;
    ISemaphore.Verifier[] iVerifiers;

    function setUp() public {
        verifier = new Verifier20();
        verifierAddress = address(verifier);

        iVerifier.contractAddress = verifierAddress;
        iVerifier.merkleTreeDepth = 20;
        iVerifiers.push(iVerifier);
    }

    function run() public {
        vm.startBroadcast();

        semaphore = new Semaphore(iVerifiers);
        semaphoreAddress = address(semaphore);

        greeter = new Greeter(semaphoreAddress, 42, 20, zeroValue);

        vm.stopBroadcast();
    }
}
