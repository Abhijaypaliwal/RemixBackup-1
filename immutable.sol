pragma solidity ^0.8.16;

contract imm{
    address public immutable addr1 = address(0);
    //address public constant addr2 = address(1);

    constructor() {
        addr1 = address(1);
    }



}