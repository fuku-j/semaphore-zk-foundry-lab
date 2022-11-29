// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

import "./Voter.sol";

struct DANCE {
    bytes32 _addrHashed;
    uint256 _merkleTreeRoot;
    uint256 _nullifierHash;
    uint256[8] _proof;
}

interface IMasquerade {
    function entry(uint256 _identityCommitment) external;

    function getMember(uint256 _identityCommitment) external returns (address);

    function dance(DANCE memory danceResource) external;
}

interface EMasquerade {
    event entryEvent(
        address indexed _memberAddress,
        uint256 _identityCommitment
    );

    event getMemberEvent(
        address indexed _memberAddress,
        uint256 _identityCommitment
    );

    event danceEvent(uint256 _groupId, uint256 _externalNullifier);
}

struct Masquerade {
    uint256 groupId;
    mapping(uint256 => address) members;
}

library MasqueradeLibrary {
    function init(Masquerade storage self, uint256 _groupId) public {
        self.groupId = _groupId;
    }

    function insert(Masquerade storage self, uint256 _identityCommitment)
        public
    {
        self.members[_identityCommitment] = msg.sender;
    }

    function memberOf(Masquerade storage self, uint256 _identityCommitment)
        public
        view
        returns (address)
    {
        return self.members[_identityCommitment];
    }

    function groupOf(Masquerade storage self) public view returns (uint256) {
        return self.groupId;
    }
}

contract MasqueradeV1 is IMasquerade, EMasquerade, VoterV1 {
    using MasqueradeLibrary for Masquerade;
    Masquerade private masquerade;

    ISemaphore private semaphore;

    constructor(
        address _semaphoreAddress,
        uint256 _groupId,
        uint256 _depth,
        uint256 _zeroValue
    ) {
        masquerade.init(_groupId);
        semaphore = ISemaphore(_semaphoreAddress);

        semaphore.createGroup(
            masquerade.groupOf(),
            _depth,
            _zeroValue,
            address(this)
        );
    }

    function entry(uint256 _identityCommitment) public override {
        semaphore.addMember(masquerade.groupOf(), _identityCommitment);

        masquerade.insert(_identityCommitment);

        emit entryEvent(msg.sender, _identityCommitment);
    }

    function dance(DANCE memory danceResource) public override {
        incrementExternalNullifier();
        uint256 externalNullifier = getExternalNullifier();

        semaphore.verifyProof(
            masquerade.groupOf(),
            danceResource._merkleTreeRoot,
            danceResource._addrHashed,
            danceResource._nullifierHash,
            masquerade.groupOf(),
            danceResource._proof
        );

        emit danceEvent(masquerade.groupOf(), externalNullifier);
    }

    function getMember(uint256 _identityCommitment)
        public
        override
        returns (address)
    {
        emit getMemberEvent(
            masquerade.memberOf(_identityCommitment),
            _identityCommitment
        );

        return masquerade.memberOf(_identityCommitment);
    }
}
