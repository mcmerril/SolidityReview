// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

contract Challange_2 {
    // Challange REQ:
    // Mint tokens to an account
    // Check balance of an account
    // Transfer tokens from one account to another

    // ---------------------
    //    State Variables
    // ---------------------

    uint public supply = 0;
    mapping(address => uint) public balance;

    // ---------------
    //    Functions
    // ---------------

    function getBalance(address account) public view returns(uint) {
        return balance[account];
    }

    function mint(address destination, uint amount) public {
        supply += amount;
        balance[destination] += amount;
    }

    function transfer(address destination, uint amount) public {
        balance[msg.sender] -= amount;
        balance[destination] += amount;
    }

}

contract Challange_2_test is Test {

    Challange_2 chall;

    function setUp() public {
        chall = new Challange_2();
    }

    function test_getBalance() public {
        uint acc_bal = chall.getBalance(address(0xB0B));
        assertEq(acc_bal, 0);
    }

    function test_mintTokens() public {
        // Pre State
        address bob = address(0xB0B);
        uint acc_bal = chall.getBalance(bob);

        assertEq(acc_bal, 0);
        assertEq(chall.supply(), 0);

        // Function Call
        chall.mint(bob, 100);

        // Post State
        acc_bal = chall.getBalance(bob);

        assertEq(acc_bal, 100);
        assertEq(chall.supply(), 100);

    }

    function test_mintTokens_fuzz(uint248 amt) public {
        //Pre State
        address bob = address(0xB0B);
        uint acc_bal = chall.getBalance(bob);

        assertEq(acc_bal, 0);
        assertEq(chall.supply(), 0);

        // Function Call
        chall.mint(bob, amt);

        // Post State
        acc_bal = chall.getBalance(bob);

        assertEq(acc_bal, amt);
        assertEq(chall.supply(),  amt);

    }

    function test_transfer() public {
        address bob = address(0xB0B);
        address coffee = address(0xC0FFEE);

        // Pre State        
        chall.mint(bob, 100);

        uint bob_acc_bal = chall.getBalance(bob);
        uint coffee_acc_bal = chall.getBalance(coffee);

        assertEq(bob_acc_bal, 100);
        assertEq(coffee_acc_bal, 0);

        // Function Call
        vm.startPrank(bob);
        chall.transfer(coffee, 100);
        vm.stopPrank();

        // Post State
        bob_acc_bal = chall.getBalance(bob);
        coffee_acc_bal = chall.getBalance(coffee);
        
        assertEq(bob_acc_bal, 0);
        assertEq(coffee_acc_bal, 100);

    }

    function test_transfer_fuzz(uint248 amt) public {
        address bob = address(0xB0B);
        address coffee = address(0xC0FFEE);

        // Pre State        
        chall.mint(bob, amt);

        uint bob_acc_bal = chall.getBalance(bob);
        uint coffee_acc_bal = chall.getBalance(coffee);

        assertEq(bob_acc_bal, amt);
        assertEq(coffee_acc_bal, 0);

        // Function Call
        vm.startPrank(bob);
        chall.transfer(coffee, amt);
        vm.stopPrank();

        // Post State
        bob_acc_bal = chall.getBalance(bob);
        coffee_acc_bal = chall.getBalance(coffee);
        
        assertEq(bob_acc_bal, 0);
        assertEq(coffee_acc_bal, amt);

    }

}
