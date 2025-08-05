// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./MyStablecoin.sol";

contract ReserveManager is Ownable {
    MyStablecoin public stableCoin;
    uint256 public reserveBalance; // Mock fiat reserve

    event ReserveUpdated(uint256 newBalance);

    constructor(address _stableCoin) Ownable(msg.sender) {
        stableCoin = MyStablecoin(_stableCoin);
    }

    function updateReserve(uint256 amount) external onlyOwner {
        reserveBalance = amount;
        emit ReserveUpdated(amount);
    }

    function mintStableCoin(address to, uint256 amount) external onlyOwner {
        require(reserveBalance >= amount, "Insufficient reserves");
        stableCoin.mint(to, amount);
    }
}