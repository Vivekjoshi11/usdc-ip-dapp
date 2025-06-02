// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface IIPToken {
    function mint(address to, uint256 amount) external;
}

contract RampConversion {
    address public owner;
    address public ipToken;
    address public usdc;

    mapping(address => uint256) public lastConversion;

    constructor(address _ipToken, address _usdc) {
        owner = msg.sender;
        ipToken = _ipToken;
        usdc = _usdc;
    }

    function convertUSDCToIP(uint256 usdcAmount) external {
        require(block.timestamp - lastConversion[msg.sender] >= 1 minutes, "Cooldown: wait 1 min");

        uint256 ipAmount = calculateRamp(usdcAmount);
        lastConversion[msg.sender] = block.timestamp;

        IERC20(usdc).transferFrom(msg.sender, address(this), usdcAmount);
        IIPToken(ipToken).mint(msg.sender, ipAmount);
    }

    function calculateRamp(uint256 amount) internal view returns (uint256) {
        // Example: simple 1:1 conversion
        return amount;
    }
}
 