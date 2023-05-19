// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Registry.sol";

import "safe-contracts/Safe.sol";

contract RegistryTest is Test {
    Registry public registry;

    function setUp() public {
        address[] memory owners = new address[](1);
        owners[0] = address(this);
        registry =
        new Registry("Test Registry", owners, 1, 0x4e1DCf7AD4e460CfD30791CCC4F9c8a4f820ec67, 0xc962E67D9490E154D81181879ddf4CD3b65D2132, 3098132);
    }

    function testRegistryOwnerIsRootRole() public {
        address owner = registry.owner();
        RoleInfo[] memory roles = registry.getRoles();
        RoleInfo memory root = roles[0];
        assertEq(owner, root.addr);
    }

    function testRootRoleOwnerIsCreator() public {
        RoleInfo memory root = registry.getRoles()[0];
        Safe rootSafe = Safe(payable(root.addr));
        address[] memory owners = rootSafe.getOwners();
        address firstRootOwner = owners[0];
        assertEq(address(this), firstRootOwner);
    }
}
