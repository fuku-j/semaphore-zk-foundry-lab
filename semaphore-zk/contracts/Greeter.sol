// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../node_modules/@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

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
    ISemaphore public semaphore;
    uint256 groupId;
    mapping(uint256 => bytes32) users;

    constructor(
        address _semaphoreAddress,
        uint256 _groupId,
        uint256 _depth,
        uint256 _zeroValue
    ) {
        groupId = _groupId;
        semaphore = ISemaphore(_semaphoreAddress);

        semaphore.createGroup(groupId, _depth, _zeroValue, address(this));
    }

    function joinGroup(uint256 _identityCommitment, bytes32 _username)
        public
        override
    {
        semaphore.addMember(groupId, _identityCommitment);
        users[_identityCommitment] = _username;

        emit NewMember(_identityCommitment, _username);
    }

    function greet(
        bytes32 _greeting,
        uint256 _merkleTreeRoot,
        uint256 _nullifierHash,
        uint256[8] calldata _proof
    ) public override {
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
