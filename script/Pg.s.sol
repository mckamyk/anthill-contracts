// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/RegistryRouter.sol";
import "../src/RegistryFactory.sol";

contract Init is Script {
    RegistryRouter router = RegistryRouter(0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e);
    RegistryFactory factory;

    function setUp() public {
        factory = RegistryFactory(router.getAddress());
    }

    function run() public view {
        Registry[] memory regs = factory.getUserRegistries(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

        console.log(regs.length);
    }
}
