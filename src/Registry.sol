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
    SafeProxyFactory proxyFactory;
    address safeSingleton;

    string public name;
    SafeProxy[] public roleSafes;
    mapping(address => RoleInfo) public roleInfo;

    event RegistryCreated(string _name);
    event RoleAdded(string _name, address _role);

    constructor(
        string memory _name,
        address[] memory _owners,
        uint256 threshold,
        address _proxyFactory,
        address _safeSingleton,
        uint256 _nonce
    ) {
        name = _name;
        proxyFactory = SafeProxyFactory(_proxyFactory);
        safeSingleton = _safeSingleton;

        SafeProxy rootProxy = _addRole("root", _nonce);
        transferOwnership(address(rootProxy));
        Safe rootSafe = Safe(payable(rootProxy));
        rootSafe.setup(_owners, threshold, address(0), new bytes(0), address(0), address(0), 0, payable(0));

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

    function _addRole(string memory _name, uint256 _nonce) private returns (SafeProxy roleProxy) {
        roleProxy = proxyFactory.createProxyWithNonce(safeSingleton, new bytes(0), _nonce);
        roleSafes.push(roleProxy);
        roleInfo[address(roleProxy)] = RoleInfo({name: _name, addr: address(roleProxy)});
    }

    function addRole(string calldata _name, uint256 _nonce) public returns (RoleInfo memory info) {
        SafeProxy roleProxy = _addRole(_name, _nonce);
        info = roleInfo[address(roleProxy)];
    }
}
