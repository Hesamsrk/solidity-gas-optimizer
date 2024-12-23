// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmptyContract{

}

contract InefficientContract1 {
    uint256[] public largeArray;
    mapping(address => uint256) public balances;
    uint256 public totalBalance;
    uint8 public anSmallVariable;
    uint8 public anotherSmallVariable;
    uint16 public justAnotheruint16;
    uint32 public justAnotheruint32;
    bool public isActive = true;
    bool public isConfirmed = false;
    bool public isTransfered = false;
    uint256 public threshold = 1000;
    string public contract_address = "0x7f367cC414f96b1D6C06e0e22dba7d17f8b4a2dB";
    string public owner_name = "owner_name_random";
    uint8[10] public fixedArray = [1,2,3,4,5,6,7,8,9,10];
    uint8[] public dynamicArray = [1,2,3,4,5,6,7,8,9,10,11];

    constructor() {
        for (uint256 i = 0; i < 100; i++) {
            largeArray.push(i);
        }
    }

    function inefficientLoop(uint256 multiplier) public {
        for (uint256 i = 0; i < largeArray.length; i++) {
            largeArray[i] *= multiplier; // Storage write in each iteration
        }
    }

    function redundantComputation(uint256 input) public pure returns (uint256) {
        uint256 value = input * input; // Computed once
        return (value + value + value); // Redundant computation
    }

    function inefficientStorageAccess(uint256 newThreshold) public {
        threshold = newThreshold;
        threshold += 1;
        threshold *= 2;
    }

    function badVisibilityFunction() public view returns (uint256) {
        return totalBalance;
    }

    function badBooleanPacking(bool flag1, bool flag2, bool flag3) public pure returns (uint256) {
        if (flag1 && flag2 && flag3) {
            return 1;
        }
        return 0;
    }

    function expensiveArrayResizing(uint256 size) public {
        for (uint256 i = 0; i < size; i++) {
            largeArray.push(i);
        }
    }

    function externalCallsExample() public {
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


contract InefficientContract2 {

    string public networkVersionUsed = "1.23.140000v54Beta";

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

    function doSomethingMemory(Person memory person2) public {
        
    }

    function doSomethingCalldata(Person calldata person3) public {
        
    }
}