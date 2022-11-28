// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IVoter {
    function incrementExternalNullifier() external;

    function getExternalNullifier() external returns (uint256);
}

interface EVoter {
    event incrementExternalNullifierEvent(
        address indexed voter,
        uint256 externalNullifier
    );

    event getExternalNullifierEvent(
        address indexed voter,
        uint256 externalNullifier
    );
}

struct Voter {
    address voter;
    uint256 externalNullifier;
}

library VoterLibrary {
    function init(Voter storage self) public {
        self.voter = msg.sender;
    }

    function increment(Voter storage self) public {
        self.externalNullifier++;
    }

    function get(Voter storage self) public view returns (uint256) {
        return self.externalNullifier;
    }

    function ownerOf(Voter storage self) public view returns (address) {
        return self.voter;
    }
}

contract VoterV1 is IVoter, EVoter {
    using VoterLibrary for Voter;
    Voter voter;

    constructor() {
        voter.init();
    }

    function incrementExternalNullifier() public override onlyVoter {
        voter.increment();

        emit incrementExternalNullifierEvent(voter.ownerOf(), voter.get());
    }

    function getExternalNullifier()
        public
        override
        onlyVoter
        returns (uint256)
    {
        emit getExternalNullifierEvent(voter.ownerOf(), voter.get());

        return voter.get();
    }

    modifier onlyVoter() {
        require(voter.ownerOf() == msg.sender, "Caller is not a voter.");
        _;
    }
}
