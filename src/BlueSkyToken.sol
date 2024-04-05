// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract BlueSkyToken is ERC20Capped {
    error BlueSkyToken__OnlyOwnercanCall();

    address payable public owner;
    uint256 public blockReward;

    constructor(
        uint256 cap,
        uint256 reward
    ) ERC20("BlueSkyToken", "BST") ERC20Capped(cap * (10 ** decimals())) {
        owner = payable(msg.sender);
        _mint(owner, 500 * (10 ** decimals()));
        blockReward = reward;
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function setblockReward(uint256 reward) public onlyOwner {
        blockReward = reward * (10 ** decimals());
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert BlueSkyToken__OnlyOwnercanCall();
        }
        _;
    }
}
