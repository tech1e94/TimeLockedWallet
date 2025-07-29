// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

error NotOwner();

contract TimeLockedWallet {
    address internal immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function getAmount() public view returns (uint256) {
        return address(this).balance;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than 0");
    }

    uint256 public unlockTime;

    function setLockTime(uint256 _time) public {
        // Accepts UNIX time format
        require(_time > block.timestamp, "Unlock time must be in future !");
        unlockTime = _time;
    }

    function withdraw() public onlyOwner returns (uint256) {
        require(block.timestamp >= unlockTime, "Too early");
        uint256 amount = address(this).balance;
        (bool callSuccess, ) = payable(msg.sender).call{value: amount}("");
        require(callSuccess, "Call failed");
        return amount;
    }

    function timeLeftToUnlock() public view returns (uint256) {
        if (block.timestamp >= unlockTime) {
            return 0;
        } else {
            return unlockTime - block.timestamp;
        }
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
