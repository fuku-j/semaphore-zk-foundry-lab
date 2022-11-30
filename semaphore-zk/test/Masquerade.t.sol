// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../contracts/Masquerade.sol";
import "../node_modules/@semaphore-protocol/contracts/Semaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "../node_modules/@semaphore-protocol/contracts/verifiers/Verifier20.sol";

contract MasqueradeTest is Test, EMasquerade {
    MasqueradeV1 masquerade;
    uint256 _groupId;
    address _memberAddress;

    Semaphore semaphore;
    address semaphoreAddress;
    uint256 _depth;
    uint256 _zeroValue;

    Verifier20 verifier;
    address verifierAddress;

    ISemaphore.Verifier iVerifier;
    ISemaphore.Verifier[] iVerifiers;

    function setUp() public {
        _memberAddress = vm.addr(999999);

        verifier = new Verifier20();
        verifierAddress = address(verifier);

        iVerifier.contractAddress = verifierAddress;
        iVerifier.merkleTreeDepth = 20;
        iVerifiers.push(iVerifier);

        semaphore = new Semaphore(iVerifiers);
        semaphoreAddress = address(semaphore);

        _groupId = 42;
        _depth = 20;
        _zeroValue = 0;

        vm.prank(_memberAddress);
        masquerade = new MasqueradeV1(
            semaphoreAddress,
            _groupId,
            _depth,
            _zeroValue
        );
    }

    function testSuccess_Masquerade_entry() public {
        address dummyMemberAddress = _memberAddress;

        uint256 dummyIdentityCommitment = 1;
        string memory dummyMemberEntity;

        string[] memory addMemberInputs = new string[](3);
        addMemberInputs[0] = "npx";
        addMemberInputs[1] = "ts-node";
        addMemberInputs[
            2
        ] = "developments/scripts/semaphoreScripts/addMemberResource.ts";

        bytes memory addMemberResourceResponse = vm.ffi(addMemberInputs);

        (dummyIdentityCommitment, dummyMemberEntity) = abi.decode(
            addMemberResourceResponse,
            (uint256, string)
        );

        vm.expectEmit(true, true, false, false);
        emit entryEvent(dummyMemberAddress, dummyIdentityCommitment);

        vm.prank(dummyMemberAddress);
        masquerade.entry(dummyIdentityCommitment);

        vm.expectEmit(true, true, false, false);
        emit getMemberEvent(dummyMemberAddress, dummyIdentityCommitment);

        vm.prank(dummyMemberAddress);
        address got = masquerade.getMember(dummyIdentityCommitment);

        assertEq(got, dummyMemberAddress);
    }

    function testSuccess_Masquerade_dance() public {
        address dummyMemberAddress = _memberAddress;

        uint256 dummyIdentityCommitment = 1;
        string memory dummyMemberEntity;

        string[] memory addMemberInputs = new string[](3);
        addMemberInputs[0] = "npx";
        addMemberInputs[1] = "ts-node";
        addMemberInputs[
            2
        ] = "developments/scripts/semaphoreScripts/addMemberResource.ts";

        bytes memory addMemberResourceResponse = vm.ffi(addMemberInputs);

        (dummyIdentityCommitment, dummyMemberEntity) = abi.decode(
            addMemberResourceResponse,
            (uint256, string)
        );

        vm.expectEmit(true, true, false, false);
        emit entryEvent(dummyMemberAddress, dummyIdentityCommitment);

        vm.prank(dummyMemberAddress);
        masquerade.entry(dummyIdentityCommitment);

        uint256 dummyGroupId = _groupId;
        uint256 dummyExternalNullifier = 1;

        DANCE memory _danceResource;

        string[] memory danceResourceInputs = new string[](4);

        danceResourceInputs[0] = "npx";
        danceResourceInputs[1] = "ts-node";
        danceResourceInputs[
            2
        ] = "developments/scripts/semaphoreScripts/verifyProofResource.ts";
        danceResourceInputs[3] = dummyMemberEntity;

        bytes memory danceResourceResponse = vm.ffi(danceResourceInputs);

        (
            _danceResource._addrHashed,
            _danceResource._merkleTreeRoot,
            _danceResource._nullifierHash,
            _danceResource._proof
        ) = abi.decode(
            danceResourceResponse,
            (bytes32, uint256, uint256, uint256[8])
        );

        vm.expectEmit(true, true, false, false);
        emit danceEvent(dummyGroupId, dummyExternalNullifier);

        vm.prank(dummyMemberAddress);
        masquerade.dance(_danceResource);
    }
}
