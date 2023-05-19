// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/RegistryRouter.sol";
import "../src/RegistryFactory.sol";

contract RegistryScript is Script {
    RegistryRouter public registryRouter = RegistryRouter(0x610178dA211FEF7D417bC0e6FeD39F05609AD788);

    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        console.log(privateKey);
        vm.startBroadcast(privateKey);

        RegistryFactory factory =
            new RegistryFactory(0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2, 0xd9Db270c1B5E3Bd161E8c8503c55cEABeE709552);

        address addr = address(factory);
        registryRouter.setAddress(addr);

        vm.stopBroadcast();
    }
}
