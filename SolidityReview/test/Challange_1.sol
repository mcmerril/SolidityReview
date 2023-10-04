// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";


contract Challange_1 {

    // ---------------------
    //    State Variables
    // ---------------------

    uint local_uint;

    // ---------------
    //    Functions
    // ---------------

    function get_int() public view returns(uint) {
        return local_uint;
    }

    function set_int(uint outside_uint) public {
        local_uint = outside_uint;
    }

}

contract Challange_1_test is Test {

    Challange_1 chall;

    function setUp() public {
        chall = new Challange_1();
    }

    function test_storage() public {
        chall.set_int(42);
        
        uint data = chall.get_int();

        assertEq(data, 42);
    }

}
