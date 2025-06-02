// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("Mock USD Coin", "USDC") {
        _mint(msg.sender, 1000000 * 1e6); // 1,000,000 USDC
    }

    function faucet(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
