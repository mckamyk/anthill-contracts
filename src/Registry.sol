// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "safe-contracts/proxies/SafeProxyFactory.sol";
import "safe-contracts/Safe.sol";

struct RoleInfo {
    string name;
    address addr;
}

contract Registry is Ownable {
    string public name;
    SafeProxy[] public roleSafes;
    mapping(address => RoleInfo) public roleInfo;
    SafeProxyFactory proxyFactory;
    address safeSingleton;

    event RegistryCreated(string _name);
    event RoleAdded(string _name, address _role);

    constructor(string memory _name, address _proxyFactory, address _safeSingleton) {
        name = _name;
        proxyFactory = SafeProxyFactory(_proxyFactory);
        safeSingleton = _safeSingleton;

        SafeProxy rootProxy = _addRole("root");

        emit RegistryCreated(_name);
    }

    function getRoles() public view returns (RoleInfo[] memory _roles) {
        RoleInfo[] memory roles = new RoleInfo[](roleSafes.length);
        for (uint256 i = 0; i < roles.length; i++) {
            roles[i] = roleInfo[address(roleSafes[i])];
        }
        return roles;
    }

    function getRole(address _role) public view returns (RoleInfo memory role) {
        return roleInfo[_role];
    }

    function _addRole(string memory _name) private returns (SafeProxy roleProxy) {
        SafeProxy foo = proxyFactory.createProxyWithNonce(safeSingleton, new bytes(0), 14321);
        roleSafes.push(roleProxy);
        roleInfo[address(roleProxy)] = RoleInfo({name: _name, addr: address(roleProxy)});
    }

    function addRole(string calldata _name) public returns (RoleInfo memory info) {
        SafeProxy roleProxy = _addRole(_name);
        info = roleInfo[address(roleProxy)];
    }
}
