// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BlueSkyToken} from "../src/BlueSkyToken.sol";
import {DeployBlueSkyToken} from "../script/DeployBlueSkyToken.s.sol";

contract BlueSkyTokenTest is Test {
    BlueSkyToken blueSkyToken;
    DeployBlueSkyToken deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        deployer = new DeployBlueSkyToken();
        blueSkyToken = deployer.run();

        vm.prank(msg.sender);
        blueSkyToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, blueSkyToken.balanceOf(bob));
    }

    function testAllowancesWork() public {
        uint256 allowance = 1000;
        vm.prank(bob);
        blueSkyToken.approve(alice, allowance);

        uint256 transferAmount = 500;
        vm.prank(alice);
        blueSkyToken.transferFrom(bob, alice, transferAmount);
        assertEq(blueSkyToken.balanceOf(alice), transferAmount);
        assertEq(
            blueSkyToken.balanceOf(bob),
            STARTING_BALANCE - transferAmount
        );
    }

    function testTransfer() public {
        uint256 transferAmount = 50;
        vm.prank(bob);
        blueSkyToken.transfer(alice, transferAmount);
        assertEq(blueSkyToken.balanceOf(alice), transferAmount);
        assertEq(
            blueSkyToken.balanceOf(bob),
            STARTING_BALANCE - transferAmount
        );
    }

    function testTransferFrom() public {
        uint256 allowance = 1000;
        vm.prank(bob);
        blueSkyToken.approve(alice, allowance);

        uint256 transferAmount = 500;
        vm.prank(alice);
        blueSkyToken.transferFrom(bob, alice, transferAmount);
        assertEq(blueSkyToken.balanceOf(alice), transferAmount);
        assertEq(
            blueSkyToken.balanceOf(bob),
            STARTING_BALANCE - transferAmount
        );
    }

    function testApprove() public {
        uint256 allowance = 1000;
        blueSkyToken.approve(alice, allowance);
        assertEq(blueSkyToken.allowance(address(this), alice), allowance);
    }
}
