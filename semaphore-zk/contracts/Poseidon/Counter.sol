// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// import "../node_modules/@zk-kit/incremental-merkle-tree.sol/Hashes.sol";
import "./Hashes.sol";

struct COUNT {
    uint256 count;
}

library IncremnetCounter {
    function init(COUNT storage self, uint256 zeroValue) public {
        self.count = zeroValue;
    }

    function insert(COUNT storage self, uint256 _count) public {
        self.count = _count;
    }

    function upsert(COUNT storage self) public {
        self.count++;
    }

    function get(COUNT storage self) public view returns (uint256) {
        return self.count;
    }
}

contract Counter {
    using IncremnetCounter for COUNT;
    COUNT private count;

    constructor(uint256 zeroValue) {
        count.init(zeroValue);
    }

    function addCount(uint256 _count) public {
        count.insert(_count);
    }

    function incrementCount() public {
        count.upsert();
    }

    function getCount() public view returns (uint256) {
        return count.get();
    }

    /**
     * @dev Test for Poseidon library
     * - Hash.sol
     * library PoseidonT3 {
     *  function poseidon(uint256[2] memory) public pure returns (uint256) {}
     * }
     */
    function hashCount(uint256 x, uint256 y) public pure returns (uint256) {
        return PoseidonT3.poseidon([x, y]);
    }
}
