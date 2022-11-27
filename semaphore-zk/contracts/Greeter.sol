// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

struct GREETERS {
    uint256 groupId;
    mapping(uint256 => bytes32) members;
}

library GreeterGroupLibrary {
    function initId(GREETERS storage self, uint256 _groupId) public {
        self.groupId = _groupId;
    }

    function getId(GREETERS storage self) public view returns (uint256) {
        return self.groupId;
    }

    function addGreeters(
        GREETERS storage self,
        uint256 _identityCommitment,
        bytes32 _username
    ) public {
        self.members[_identityCommitment] = _username;
    }
}

interface IGreeter {
    function joinGroup(uint256 identityCommitment, bytes32 username) external;

    function greet(
        bytes32 greeting,
        uint256 merkleTreeRoot,
        uint256 nullifierHash,
        uint256[8] calldata proof
    ) external;
}

interface EGreeter {
    event NewMember(uint256 identityCommitment, bytes32 username);
    event NewGreeting(bytes32 greeting);
}

contract Greeter is IGreeter, EGreeter {
    using GreeterGroupLibrary for GREETERS;
    GREETERS private greeters;

    ISemaphore public semaphore;

    constructor(
        address _semaphoreAddress,
        uint256 _groupId,
        uint256 _depth,
        uint256 _zeroValue
    ) {
        greeters.initId(_groupId);
        semaphore = ISemaphore(_semaphoreAddress);

        semaphore.createGroup(
            greeters.getId(),
            _depth,
            _zeroValue,
            address(this)
        );
    }

    function joinGroup(uint256 _identityCommitment, bytes32 _username)
        public
        override
    {
        semaphore.addMember(greeters.getId(), _identityCommitment);

        greeters.addGreeters(_identityCommitment, _username);

        emit NewMember(_identityCommitment, _username);
    }

    function greet(
        bytes32 _greeting,
        uint256 _merkleTreeRoot,
        uint256 _nullifierHash,
        uint256[8] calldata _proof
    ) public override {
        uint256 groupId = greeters.getId();

        semaphore.verifyProof(
            groupId,
            _merkleTreeRoot,
            _greeting,
            _nullifierHash,
            groupId,
            _proof
        );
        emit NewGreeting(_greeting);
    }
}
