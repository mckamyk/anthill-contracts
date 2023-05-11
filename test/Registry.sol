// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Registry.sol";

import "safe-contracts/Safe.sol";

contract CounterTest is Test {
    Registry public registry;

    function setUp() public {
        registry =
        new Registry("Test Registry", 0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2, 0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552);
    }

    function testRegistryOwnerIsRootRole() public {
        address owner = registry.owner();
        RoleInfo[] memory roles = registry.getRoles();
        RoleInfo memory root = roles[0];
        assertEq(owner, root.addr);
    }

    function testRootRoleOwnerIsSender() public {
        RoleInfo memory root = registry.getRoles()[0];
        Safe rootSafe = Safe(payable(root.addr));
        console.log(root.addr);
        address firstRootOwner = rootSafe.getOwners()[0];
        assertEq(msg.sender, firstRootOwner);
    }
}
