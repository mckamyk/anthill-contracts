// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Registry.sol";
import "../src/RegistryFactory.sol";
import "safe-contracts/Safe.sol";

contract RegistryFactoryTest is Test {
    RegistryFactory public registryFactory;

    function setUp() public {
        registryFactory =
            new RegistryFactory(0x4e1DCf7AD4e460CfD30791CCC4F9c8a4f820ec67, 0xc962E67D9490E154D81181879ddf4CD3b65D2132);
    }

    function dep() internal returns (Registry _registry) {
        address[] memory owners = new address[](1);
        owners[0] = address(this);
        address registry = registryFactory.deployRegistry("Test Registry", owners, 1, 234123);
        _registry = Registry(registry);
    }

    function testDeployRegistry() public {
        dep();
        assertEq(registryFactory.totalRegistries(), 1);
    }

    function testRegistryRootOwnerIsCaller() public {
        Registry registry = dep();
        RoleInfo memory root = registry.getRoles()[0];
        Safe rootSafe = Safe(payable(root.addr));
        address[] memory owners = rootSafe.getOwners();
        address firstRootOwner = owners[0];
        console.log("msg.sender:\t%s", msg.sender);
        console.log("FactoryAddr:\t%s", address(registryFactory));
        console.log("RegAddr:\t%s", address(registry));
        console.log("AddressTest:\t%s", address(this));
        assertEq(address(this), firstRootOwner);
    }
}
