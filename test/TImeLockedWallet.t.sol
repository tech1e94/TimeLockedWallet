// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {TimeLockedWallet} from "../src/TimeLockedWallet.sol";

contract TimeLockedWAlletTest is Test {
    TimeLockedWallet public wallet;

    function setUp() public {
        wallet = new TimeLockedWallet();
    }

    function testSetLockTime() public {
        wallet.setLockTime(block.timestamp + 1 days);
        assertTrue(wallet.unlockTime() > block.timestamp);
    }
}
