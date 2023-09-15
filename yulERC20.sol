// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Used in the `name()` function
bytes32 constant nameLength = 0x0000000000000000000000000000000000000000000000000000000000000009;
bytes32 constant nameData = 0x59756c20546f6b656e0000000000000000000000000000000000000000000000;

// Used in the `symbol()` function
bytes32 constant symbolLength = 0x0000000000000000000000000000000000000000000000000000000000000003;
bytes32 constant symbolData = 0x59554c0000000000000000000000000000000000000000000000000000000000;

// `bytes4(keccak256("InsufficientBalance()"))`
bytes32 constant insufficientBalanceSelector = 0xf4d678b800000000000000000000000000000000000000000000000000000000;

// `bytes4(keccak256("InsufficientAllowance(address,address)"))`
bytes32 constant insufficientAllowanceSelector = 0xf180d8f900000000000000000000000000000000000000000000000000000000;

error InsufficientBalance();
error InsufficientAllowance(address owner, address spender);

bytes32 constant transferHash = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef;
bytes32 constant approvalHash = 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925;

/// @title Yul ERC20
/// @author <your name here>
/// @notice For demo purposes ONLY.
contract YulERC20 {
    mapping(address => uint256) internal _balances;
    mapping(address => mapping(address => uint256)) internal _allowances;
    event Transfer(
        address indexed sender,
        address indexed receiver,
        uint256 amount
    );

    event Approve(address indexed owner, address indexed spender, uint256 amount);

    function name() public pure returns (string memory) {
        assembly {
            let memptr := mload(0x40)
            mstore(memptr, 0x20)
            mstore(add(memptr, 0x20), nameLength)
            mstore(add(memptr, 0x40), nameData)
            return(memptr, 0x60)
        }
    }

    function symbol() public pure returns (string memory) {
        assembly {
            let memptr := mload(0x40)
            mstore(memptr, 0x20)
            mstore(add(memptr, 0x20), symbolLength)
            mstore(add(memptr, 0x40), symbolData)
            return(memptr, 0x60)
        }
    }

    function decimals() public pure returns (uint8) {
        assembly {
            mstore(0, 18)
            return(0x00, 0x20)
        }
    }

    function balanceOf(address) public view returns (uint256) {
        assembly {
            let account := calldataload(4)
            mstore(0x00, account) // storing address in slot 0x00 to slot 0x20
            mstore(0x20, 0x00) // now adding padding of 0 from 0x20 to 0x40 (32 bytes)

            let hash := keccak256(0x00, 0x40) // hashing the account address from 0x00 to 0x40 (with padding)
            let accountBalance := sload(hash) // now putting that hash to storage and fetching balances (hash of acc point to balance in storage)

            mstore(0x00, accountBalance) // overriding the 0x00 to account balance
            return(0x00, 0x20) // returning balance
        }
    }

    function initbal() external {
        _balances[
            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        ] = 10000000000000000000000000000000;
    }

    function transfer(address receiver, uint256 value) public returns (bool) {
        assembly {
            let memptr := mload(0x40)
            mstore(memptr, caller())
            mstore(add(memptr, 0x20), 0x00)
            let callerBalanceSlot := keccak256(memptr, 0x40)
            let callerBalance := sload(callerBalanceSlot)

            if lt(callerBalance, value) {
                mstore(0x00, insufficientBalanceSelector)
                revert(0x00, 0x04)
            }

            let newCallerBalance := sub(callerBalance, value)
            mstore(memptr, receiver)
            mstore(add(memptr, 0x20), 0x00)
            let receiverBalanceSlot := keccak256(memptr, 0x40)
            let receiverBalance := sload(receiverBalanceSlot)

            let newReceiverBalance := add(receiverBalance, value)

            sstore(callerBalanceSlot, newCallerBalance)

            sstore(receiverBalanceSlot, newReceiverBalance)
            mstore(0x00, value)
            log3(0x00, 0x20, transferHash, caller(), receiver)

            mstore(0x00, 0x01)
            return(0x00, 0x20)
        }
    }

    function allowance(address owner, address spender) public view returns(uint256) {

        assembly {
            mstore(0x00, caller())
            mstore(0x20, 0x01)
            let innerHash := keccak256(0x00, 0x40)
            mstore(0x00, spender)
            mstore(0x20, innerHash) 
            let allowanceSlot := keccak256(0x00, 0x40)
            let allowanceValue := sload(allowanceSlot)
            mstore(0x00, allowanceSlot)
            return(0x00, 0x20)


        }
    }

    function approve(address owner, uint256 amount) public returns(bool){
        assembly {
            mstore(0x00, caller())
            mstore(0x20, 0x01)
            let innerHash := keccak256(0x00, 0x40)
            mstore(0x00, spender)
            mstore(0x20, innerHash) 
            let allowanceSlot := keccak256(0x00, 0x40)
            sstore(allowanceSlot, amount )
            mstore(0x00, amount)
            log3(0x00, 0x20, approvalHash, caller(), spender)

            mstore(0x00, 0x01)
            return(0x00, 0x20)

        }

    } 

    function transferFrom()
}
