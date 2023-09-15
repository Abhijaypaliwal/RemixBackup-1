// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;
/// @title A contract for demonstrate custom error
/// @author Jitendra Kumar
/// @notice For now, this contract just show how custom error generates if owner address amount is less than withdraw amount
contract CustomError {
	//mapping
	mapping(address => uint) public bal;

	//amount deposit to owner address
	function deposit() public payable {
		bal[msg.sender] += msg.value;
	}

	// custom error statement
	error LackOfFunds(uint withdrawAmt, uint availableAmt);
	
	//custom error generates if withdraw amount is greater than owner address amount
	function checkCustomError(address _receiver,uint _withdrawAmt) public {
		if (bal[msg.sender]< _withdrawAmt) {
			revert LackOfFunds({withdrawAmt: _withdrawAmt, availableAmt: bal[msg.sender]});
		}
		bal[msg.sender] -= _withdrawAmt;
		bal[_receiver]+=_withdrawAmt;
	}
}
