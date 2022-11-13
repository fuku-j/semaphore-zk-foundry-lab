// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../contracts/Poseidon/Counter.sol";

/**
 * @dev CounterTest is Unit test for PoseidonT3 library.
 *
 * - example for cast cli
 * forge test -c test/Counter.t.sol -m testSuccess_Hash -vvvvv
 */
contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        uint256 _zero;
        counter = new Counter(_zero);
    }

    function testSuccess_Hash() public {
        uint256 dummyHash;
        uint256 dummyCount = 1;

        counter.addCount(dummyCount);
        counter.incrementCount();

        uint256 got = counter.getCount();

        assertEq(got, 2);

        dummyHash = counter.hashCount(dummyCount, got);
        assertEq(dummyHash, 0);
    }
}
