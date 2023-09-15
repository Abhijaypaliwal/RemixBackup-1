// SPDX-License-Identifier: UNLICENSED
 pragma solidity 0.8.18;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTreeWhiteListChecker {
    bytes32 public rootHash;
    uint256 public count;
    address public admin;

    modifier onlyowner() {
        require(msg.sender == admin, "admin can call the function");
        _;
    }
    
    constructor(){
        admin = msg.sender;
    }

    function setRootHash(bytes32 _hash) external onlyowner returns(bool) {
        rootHash = _hash;
    }

    function setAdmin(address _admin) external onlyowner returns(bool) {
        _admin = _admin;
        return true;
    }

    function isValidProof(bytes32[] calldata proof, address _addr)  external view returns (bool) {
        // bytes memory leaf = abi.encodePacked(_addr);
        return MerkleProof.verify(proof, rootHash,  keccak256(abi.encodePacked(_addr)));
    }

}