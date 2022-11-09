// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../contracts/Greeter.sol";

import "../node_modules/@semaphore-protocol/contracts/Semaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/verifiers/Verifier16.sol";

contract GreeterTest is Test, EGreeter {
    Greeter greeter;
    address member;
    uint256 groupId;

    Semaphore semaphore;
    address semaphoreAddress;
    uint256 depth;
    uint256 zeroValue;

    Verifier16 verifier;
    address verifierAddress;

    ISemaphore.Verifier iVerifier;
    ISemaphore.Verifier[] iVerifiers;

    function setUp() public {
        member = vm.addr(99999);

        verifier = new Verifier16();
        verifierAddress = address(verifier);

        iVerifier.contractAddress = verifierAddress;
        iVerifier.merkleTreeDepth = 20;
        iVerifiers.push(iVerifier);

        semaphore = new Semaphore(iVerifiers);
        semaphoreAddress = address(semaphore);

        groupId = 42;
        depth = 20;
        zeroValue = 0;

        // Instantiate Greeter contract and create new Group.
        vm.prank(member);
        greeter = new Greeter(semaphoreAddress, groupId, depth, zeroValue);
    }

    /**
     * @dev Unit test for addMember method.
     */
    function testSuccess_joinGroup() public {
        uint256 dummyIdentityCommitment;
        bytes32 dummyUsername;
        string memory dummyIdentityEntity; // Note: not use variables for this test case.

        vm.expectEmit(true, true, false, false);
        emit NewMember(dummyIdentityCommitment, dummyUsername);

        string[] memory addMemberInputs = new string[](3);
        addMemberInputs[0] = "npx";
        addMemberInputs[1] = "ts-node";
        addMemberInputs[2] = "developments/scripts/addMemberResource.ts";

        bytes memory addMemberResourceResponse = vm.ffi(addMemberInputs);
        (dummyIdentityCommitment, dummyUsername, dummyIdentityEntity) = abi
            .decode(addMemberResourceResponse, (uint256, bytes32, string));

        // Add new member.
        vm.prank(member);
        greeter.joinGroup(dummyIdentityCommitment, dummyUsername);
    }

    /**
     * @dev Unit test for verifyProof method.
     */
    function testSuccess_greet() public {
        uint256 dummyIdentityCommitment;
        bytes32 dummyUsername;
        string memory dummyIdentityEntity;

        vm.expectEmit(true, true, false, false);
        emit NewMember(dummyIdentityCommitment, dummyUsername);

        string[] memory addMemberInputs = new string[](3);
        addMemberInputs[0] = "npx";
        addMemberInputs[1] = "ts-node";
        addMemberInputs[2] = "developments/scripts/addMemberResource.ts";

        bytes memory addMemberResourceResponse = vm.ffi(addMemberInputs);
        (dummyIdentityCommitment, dummyUsername, dummyIdentityEntity) = abi
            .decode(addMemberResourceResponse, (uint256, bytes32, string));

        // Add new member.
        vm.prank(member);
        greeter.joinGroup(dummyIdentityCommitment, dummyUsername);

        bytes32 dummyGreeting;
        uint256 dummyMerkleTreeRoot;
        uint256 dummyNullifierHash;
        uint256[8] memory dummyProof;

        // Note: Revert reason is "Semaphore__GroupDoesNotExist".
        vm.expectEmit(true, false, false, false);
        emit NewGreeting(dummyGreeting);

        string[] memory verifyProofInputs = new string[](4);
        verifyProofInputs[0] = "npx";
        verifyProofInputs[1] = "ts-node";
        verifyProofInputs[2] = "developments/scripts/verifyProofResource.ts";
        verifyProofInputs[3] = dummyIdentityEntity;

        bytes memory verifyProofRespponse = vm.ffi(verifyProofInputs);
        (
            dummyGreeting,
            dummyMerkleTreeRoot,
            dummyNullifierHash,
            dummyProof
        ) = abi.decode(
            verifyProofRespponse,
            (bytes32, uint256, uint256, uint256[8])
        );

        // verify proof.
        greeter.greet(
            dummyGreeting,
            dummyMerkleTreeRoot,
            dummyNullifierHash,
            dummyProof
        );
    }
}
