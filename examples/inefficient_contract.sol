// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnoptimizedContract {
    uint256[] public largeArray;
    mapping(address => uint256) public balances;
    uint256 public totalBalance;
    bool public isActive = true;
    uint256 public threshold = 1000;

    constructor() {
        // Inefficient Initialization:
        // - Populates a large array directly in storage, which incurs high gas costs.
        // - Better approach: Initialize in memory and batch update storage.
        for (uint256 i = 0; i < 100; i++) {
            largeArray.push(i);
        }
    }

    function inefficientLoop(uint256 multiplier) public {
        /* Inefficiencies:
         * - Writes to storage (`largeArray[i]`) in every iteration, which is expensive.
         * - Instead, copy the array to memory, process in memory, and write back to storage once.
         */
        for (uint256 i = 0; i < largeArray.length; i++) {
            largeArray[i] *= multiplier; // Storage write in each iteration
        }
    }

    function redundantComputation(uint256 input) public pure returns (uint256) {
        /* Inefficiencies:
         * - Recomputes the same value multiple times in the return statement.
         * - Instead, calculate once and reuse the result to save gas.
         */
        uint256 value = input * input; // Computed once
        return (value + value + value); // Redundant computation
    }

    function inefficientStorageAccess(uint256 newThreshold) public {
        /* Inefficiencies:
         * - Updates storage multiple times instead of caching the value in memory.
         * - Better approach: Use a memory variable for intermediate computations.
         */
        threshold = newThreshold;
        threshold += 1;
        threshold *= 2;
    }

    function badVisibilityFunction() public view returns (uint256) {
        /* Inefficiencies:
         * - This function is only called externally but is marked `public`.
         * - Use `external` visibility to save gas when passing parameters.
         */
        return totalBalance;
    }

    function badBooleanPacking(bool flag1, bool flag2, bool flag3) public pure returns (uint256) {
        /* Inefficiencies:
         * - Does not pack Boolean variables into a single `uint256`.
         * - Better approach: Pack multiple Booleans into one variable for gas savings.
         */
        if (flag1 && flag2 && flag3) {
            return 1;
        }
        return 0;
    }

    function expensiveArrayResizing(uint256 size) public {
        /* Inefficiencies:
         * - Resizes a dynamic array (`largeArray`) in storage, which is costly.
         * - Instead, process the array in memory first and then update storage.
         */
        for (uint256 i = 0; i < size; i++) {
            largeArray.push(i);
        }
    }

    function externalCallsExample() public {
        /* Inefficiencies:
         * - Makes multiple external calls (`getBalance` and `getTotalBalance`), which are expensive.
         * - Instead, combine multiple data retrievals into a single function call.
         */
        balances[msg.sender] = getBalance(msg.sender);
        totalBalance = getTotalBalance();
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }

    function getTotalBalance() public view returns (uint256) {
        return totalBalance;
    }
}


contract InefficientStructPacking {
    struct Person {
        uint256 id;       // 32 bytes
        bool isActive;    // 1 byte
        uint8 age;        // 1 byte
        uint256 balance;  // 32 bytes
    }

    struct Car {
        uint256 id;       // 32 bytes
        uint8 numberOfWheels;       // 1 bytes
        bool isActive;    // 1 byte
        uint8 age;        // 1 byte
        uint8 numberOfPassangers;       // 1 bytes
        uint256 balance;  // 32 bytes
        bool isSuperCar;    // 1 byte
        uint128 gasCunsumption;       // 16 bytes
    }

    Person public person;

    function setPerson(uint256 _id, bool _isActive, uint8 _age, uint256 _balance) external {
        person.id = _id;
        person.isActive = _isActive;
        person.age = _age;
        person.balance = _balance;
    }

    function getPerson() external view returns (uint256, bool, uint8, uint256) {
        return (person.id, person.isActive, person.age, person.balance);
    }
}