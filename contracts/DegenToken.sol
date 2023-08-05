// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    // Mint new tokens (only callable by the owner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Redeem tokens for in-game items
    function redeem(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens");
        _burn(msg.sender, amount);
        // Perform in-game redemption logic here
        // For example, you can emit an event indicating the redemption
        emit RedeemedInGameItems(msg.sender, amount);
    }

    // Burn tokens
    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Not enough tokens");
        _burn(msg.sender, amount);
    }

    // Event to indicate in-game redemption
    event RedeemedInGameItems(address indexed user, uint256 amount);
}
