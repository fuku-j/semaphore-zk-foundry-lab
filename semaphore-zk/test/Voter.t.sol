// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../contracts/Voter.sol";

contract VoterTest is Test, EVoter {
    VoterV1 voter;
    address _voter;

    function setUp() public {
        _voter = vm.addr(9999999);

        vm.prank(_voter);
        voter = new VoterV1();
    }

    function testSuccess_Voter_incrementExternalNullifier() public {
        address dummyVoterAddress = _voter;
        uint256 dummyExternalNullifier = 1;

        vm.expectEmit(true, true, false, false);
        emit incrementExternalNullifierEvent(
            dummyVoterAddress,
            dummyExternalNullifier
        );

        vm.prank(dummyVoterAddress);
        voter.incrementExternalNullifier();

        vm.expectEmit(true, true, false, false);
        emit getExternalNullifierEvent(
            dummyVoterAddress,
            dummyExternalNullifier
        );

        vm.prank(dummyVoterAddress);
        uint256 got = voter.getExternalNullifier();

        assertEq(got, dummyExternalNullifier);
    }

    function testFail_Voter_incrementExternalNullifier() public {
        address dummyVoterAddress = vm.addr(1111111);
        uint256 dummyExternalNullifier = 1;

        vm.expectEmit(true, true, false, false);
        emit incrementExternalNullifierEvent(
            dummyVoterAddress,
            dummyExternalNullifier
        );

        vm.prank(dummyVoterAddress);
        vm.expectRevert(bytes("Caller is not a voter."));
        voter.incrementExternalNullifier();
    }

    function testFail_Voter_getExternalNullifier() public {
        address dummyVoterAddress = vm.addr(1111111);
        uint256 dummyExternalNullifier = 1;

        vm.expectEmit(true, true, false, false);
        emit incrementExternalNullifierEvent(
            dummyVoterAddress,
            dummyExternalNullifier
        );

        vm.prank(_voter);
        voter.incrementExternalNullifier();

        vm.expectEmit(true, true, false, false);
        emit getExternalNullifierEvent(
            dummyVoterAddress,
            dummyExternalNullifier
        );

        vm.prank(dummyVoterAddress);
        vm.expectRevert(bytes("Caller is not a voter."));
        voter.getExternalNullifier();
    }
}
