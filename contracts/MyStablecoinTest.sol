// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "remix_tests.sol";
import "./MyStablecoin.sol";
import "./ReserveManager.sol";

contract MyStablecoinTest {
    MyStablecoin stableCoin;
    ReserveManager reserveManager;
    address tester;
    address nonOwner;

    function beforeEach() public {
        tester = address(this);
        nonOwner = address(0x123); // Mock non-owner address
        stableCoin = new MyStablecoin(tester);
        reserveManager = new ReserveManager(address(stableCoin));
    }

    function checkSuccess() public {
        // Test minting 100 tokens as owner
        stableCoin.mint(tester, 100 * 10 ** 18);
        Assert.equal(
            stableCoin.balanceOf(tester),
            1000000 * 10 ** 18 + 100 * 10 ** 18,
            "Mint should increase balance"
        );
    }

    function checkSuccess2() public {
        // Test burning 50 tokens after minting
        stableCoin.mint(tester, 100 * 10 ** 18);
        stableCoin.burn(tester, 50 * 10 ** 18);
        Assert.equal(
            stableCoin.balanceOf(tester),
            1000000 * 10 ** 18 + 50 * 10 ** 18,
            "Burn should decrease balance"
        );
    }

    function checkFailure() public {
        // Test minting as non-owner (should revert)
        (bool success, ) = address(stableCoin).call(
            abi.encodeWithSignature("mint(address,uint256)", nonOwner, 100 * 10 ** 18)
        );
        Assert.equal(success, false, "Mint should fail for non-owner");
    }

    function checkSenderAndValue() public {
        // Test reserve-based minting
        reserveManager.updateReserve(100 * 10 ** 18);
        reserveManager.mintStableCoin(tester, 50 * 10 ** 18);
        Assert.equal(
            stableCoin.balanceOf(tester),
            1000000 * 10 ** 18 + 50 * 10 ** 18,
            "Reserve mint should increase balance"
        );
        Assert.equal(msg.sender, address(this), "Sender should be test contract");
    }
}