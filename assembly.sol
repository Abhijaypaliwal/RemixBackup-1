pragma solidity ^0.8.16;

contract demoAssembly {

    function setStr() public pure  returns(uint) {
        uint a = 10;

        assembly {
            let c := add(a, 23)
            mstore(c, 0x30)
            return (0x30,32)

            // {
            //    let d := add(mload(c), 10)
            //    mstore(d, 0x60)
            //    return(0x60,32)

            // }
          

        }
    }
}