// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @dev HashContract
 * -
 * forge create --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 contracts/HashContract/HashContract.sol:PoseidonT3
 *
 * - example for deploy evidence
 * Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
 * Deployed to: 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
 * Transaction hash: 0x41887b22b644cd491665c87b884d8f82e27a2d33b23f294cf499921c308e6443
 */

library PoseidonT3 {
    function poseidon(uint256[2] memory) public pure returns (uint256) {}
}
