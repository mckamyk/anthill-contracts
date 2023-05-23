// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/RegistryRouter.sol";
import "../src/RegistryFactory.sol";

contract Init is Script {
    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        RegistryRouter router = new RegistryRouter();
        RegistryFactory factory =
            new RegistryFactory(0x4e1DCf7AD4e460CfD30791CCC4F9c8a4f820ec67, 0xc962E67D9490E154D81181879ddf4CD3b65D2132);

        router.setAddress(address(factory));

        console.log("RegistryRouter address: %s", address(router));

        vm.stopBroadcast();
    }
}
