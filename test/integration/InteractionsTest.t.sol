// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe public fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether; // 100000000000000000 wei
    uint256 constant STARTING_BALANCE = 10 ether; // 1000000000000000000 wei
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        //fundMe = new FundMe();
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); // deal 10 ether to USER
    }
    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        // vm.prank(USER);
        // vm.deal(USER, 1E18);
        fundFundMe.fundFundMe(address(fundMe));

        // address funder = fundMe.getFunder(0);
        // assertEq(funder, USER);
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
