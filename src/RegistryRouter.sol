// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Registry.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract RegistryRouter is Ownable {
    address public FactoryAddress;

    constructor() {
        FactoryAddress;
    }

    function setAddress(address _factory) public onlyOwner {
        FactoryAddress = _factory;
    }

    function getAddress() public view returns (address _address) {
        _address = FactoryAddress;
    }
}
