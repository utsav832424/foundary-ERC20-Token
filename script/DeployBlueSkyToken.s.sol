// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BlueSkyToken} from "../src/BlueSkyToken.sol";

contract DeployBlueSkyToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (BlueSkyToken) {
        vm.startBroadcast();
        BlueSkyToken blueSkyToken = new BlueSkyToken(INITIAL_SUPPLY, 2);
        vm.stopBroadcast();
        return blueSkyToken;
    }
}
