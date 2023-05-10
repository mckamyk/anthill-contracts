// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract Registry is Ownable {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}
