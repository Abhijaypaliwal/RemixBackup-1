pragma solidity ^0.8.16;

contract temp {
    uint256 savingsDepositRate = 2;

    function calculate() public view returns (uint256) {
        uint256 calculatedInterest = (((1723436032 - block.timestamp) /
            (24 * 60 * 60)) *
            ((5000 * (10**17) * savingsDepositRate) / (100 * 365))) / (10**17); // * ((block.timestamp - 1694405632)/ 24*60*60) ;// (365 * 24 * 60 * 60);
        return calculatedInterest;
    }
}

contract temp2 {
    struct userDepositInfo {
        uint256 timestamp;
        uint256 interestRate;
        uint256 DepositinRupees;
    }

    userDepositInfo depositStruct;
    uint256 numberOfDeposits;

    userDepositInfo[] public depositArray;
    mapping(address => userDepositInfo[]) public depositDetailsUser;

    //mapping(uint => userDepositInfo) public depositMapping;

    function deposit() public returns (bool) {
        depositStruct.timestamp = block.timestamp;
        depositStruct.interestRate = 6;
        depositStruct.DepositinRupees = 1000;
        numberOfDeposits++;
        //depositMapping[numberOfDeposits] = depositStruct;
        depositDetailsUser[msg.sender].push(depositStruct);
    }

    function fetchResults() public view returns (uint256) {
        ///return depositMapping[msg.sender].timestamp;
    }

    function testStruct(uint256 month) public pure returns(uint){
        uint interest;
        assembly {
            switch month
            case 3 {
                interest := 4
            }
            case 6 {
                interest := 5
            }
            case 9 {
                interest := 6
            }
            case 12 {
                interest := 12
            }
            default {
                revert(0, 0)
            }
        }
        return interest;


    }
}

    contract temp3 {

        uint[] public x;

        function temp4() public {
            for(uint i = 0; i <=10; i++) {
                if(i == 4) {
                    continue;
                }
                x.push(i);
            }
        }

    }

