// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../contracts/Masquerade.sol";

contract MasqueradeTest is Test {
    Masquerade masquerade;

    function setUp() public {
        masquerade = new Masquerade();
    }

    function test_success_Masquerade() public {
        assertTrue(true);
    }
}
