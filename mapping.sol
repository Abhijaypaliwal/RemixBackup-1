pragma solidity ^0.8.16;


contract mappint {

    mapping(uint => uint ) public hello;

     function initMapping(uint key, uint _val) public {
        hello[key] = _val;
     }
    

    function changeMapping(uint key, uint _val) public {
        hello[key] = 1;

        uint slot;

        assembly {
            slot:= hello.slot
        }
        bytes32 location = keccak256(abi.encode(key, uint256(slot)));

        assembly {
            _val := add(_val,sload(location))
            sstore(location, _val)
        }
    }
}