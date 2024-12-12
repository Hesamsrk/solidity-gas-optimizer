// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BooleanPacking {
    uint256 private packedBooleans;

    // Define the number of booleans to pack
    uint256 constant NUM_BOOLEANS = 32;

    // Helper function to create a mask for a specific bit position
    function createMask(uint256 index) private pure returns (uint256) {
        return 1 << index;
    }

    // Function to pack multiple booleans into a single uint256
    function packBooleans(bool[] memory bools) public pure returns (uint256) {
        require(bools.length == NUM_BOOLEANS, "Incorrect number of booleans");

        uint256 packedValue = 0;
        for (uint256 i = 0; i < NUM_BOOLEANS; i++) {
            if (bools[i]) {
                packedValue |= createMask(i);
            }
        }
        return packedValue;
    }

    // Function to unpack a uint256 into multiple booleans
    function unpackBooleans(uint256 packedValue) public pure returns (bool[] memory) {
        bool[] memory unpackedBools = new bool[](NUM_BOOLEANS);
        for (uint256 i = 0; i < NUM_BOOLEANS; i++) {
            unpackedBools[i] = (packedValue & createMask(i)) != 0;
        }
        return unpackedBools;
    }
}