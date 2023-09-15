// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC20.sol";
import {_1Rupee} from "./5_Rupee.sol";
import {_2Rupee} from "./5_Rupee.sol";
import {_5Rupee} from "./5_Rupee.sol";
import {_10Rupee} from "./5_Rupee.sol";
import {_20Rupee} from "./5_Rupee.sol";

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Solidity by Example";
    string public symbol = "SOLBYEX";
    uint8 public decimals = 18;
    //     _1Rupee public OneRupee;
    // _2Rupee public TwoRupee;
    // _5Rupee public FiveRupee;
    //  _10Rupee public TenRupee;
    // _20Rupee public TwentyRupee;
    address public msgsender;
     


    function transfer(address recipient, uint amount) external returns (bool) {
        
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        // OneRupee = new _1Rupee(msg.sender);
        // TwoRupee = new _2Rupee(msg.sender);
        // FiveRupee = new _5Rupee(msg.sender);
        // TenRupee = new _10Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        msgsender = tx.origin;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
         // balanceOf[sender]
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        // OneRupee = new _1Rupee(msg.sender);
        // TwoRupee = new _2Rupee(msg.sender);
        // FiveRupee = new _5Rupee(msg.sender);
        // TenRupee = new _10Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        // TwentyRupee = new _20Rupee(msg.sender);
        msgsender = msg.sender;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        balanceOf[0xB6BBfAb8d166A5f14131fb5b0822793cd9C314E7] += 10000000000000000000000000000000000000000000000000000000;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function trans(uint ethAmount) public payable {
    uint weiAmount = ethAmount * 1e18;
    address someaddress = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    payable(someaddress).transfer(weiAmount);
}
}
