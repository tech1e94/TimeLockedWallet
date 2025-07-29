// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {TimeLockedWallet} from "../src/TimeLockedWallet.sol";

contract DeployTimeLockedWalled is Script {
    function run() external {
        vm.startBroadcast();
        new TimeLockedWallet();
        vm.stopBroadcast();
        // return sampleContract;
    }
}
