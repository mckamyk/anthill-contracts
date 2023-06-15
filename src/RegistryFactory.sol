// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Registry.sol";

contract RegistryFactory {
    address proxyFactory;
    address safeSingleton;

    uint256 public totalRegistries;
    mapping(address => Registry[]) public userRegistries;

    event RegistryCreated(address registry, address owner);

    constructor(address _proxyFactory, address _safeSingleton) {
        proxyFactory = _proxyFactory;
        safeSingleton = _safeSingleton;
    }

    function deployRegistry(string memory _name, address[] memory _owners, uint256 threshold, uint256 _nonce)
        public
        returns (address)
    {
        Registry registry = new Registry(_name, _owners, threshold, proxyFactory, safeSingleton, _nonce);
        totalRegistries++;
        userRegistries[msg.sender].push(registry);
        emit RegistryCreated(address(registry), msg.sender);
        return address(registry);
    }

    function getUserRegistries() public view returns (Registry[] memory _registries) {
        return userRegistries[msg.sender];
    }

    function getUserRegistries(address _user) public view returns (Registry[] memory _registries) {
        return userRegistries[_user];
    }

    function getUserRegistryAddresses() public view returns (address[] memory _registries) {
        Registry[] memory regs = getUserRegistries();
        for (uint256 i; i < regs.length; i++) {
            _registries[i] = address(regs[i]);
        }
    }

    function getUserRegistryAddresses(address _user) public view returns (address[] memory _registries) {
        Registry[] memory regs = getUserRegistries(_user);
        for (uint256 i; i < regs.length; i++) {
            _registries[i] = address(regs[i]);
        }
    }
}
