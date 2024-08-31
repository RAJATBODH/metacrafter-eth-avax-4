// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract Degen_Gaming is ERC20, ERC20Burnable {

    address public headquarters;

    // Mapping the address with their respective balance and NFT with the reward
    mapping(uint256 => NFT) public Reward;
    mapping(address => string[]) public redeemedItems;

    struct NFT {
        string name;
        uint256 price;
    }

    // Initiate a constructors
    constructor() ERC20("Degen", "DGN"){
        headquarters = msg.sender;
        Reward[0] = NFT("Diamond Boots", 2);
        Reward[1] = NFT("Diamond Sword", 3);
        Reward[2] = NFT("Name Change Card", 5);
    }

    // Modifier to allow only owner to mint the tokens
    modifier ownerOnly() {
        require(msg.sender == headquarters, "Headquarters has rights to mint new token");
        _;
    }

    // Functions to mint, transfer, burn, check balance, and redeem rewards
    function mint(uint amount, address receiver_address) ownerOnly external {
        require(amount > 0, "Minting amount should be more than 0");
        _mint(receiver_address, amount);
    }

    function transferTokens(uint amount, address receiver_address) external {
        require(amount <= balanceOf(msg.sender), "Amount should be less than the sender balance");
        _transfer(msg.sender, receiver_address, amount);
    }

    function burn(uint amount) public override {
        require(amount <= balanceOf(msg.sender), "Amount should not be more than balance");
        _burn(msg.sender, amount);
    }

    function checkBalance(address user_address) external view returns (uint) {
        return balanceOf(user_address);
    }

    function redeem(uint reward_ID) external returns (string memory) {
        require(Reward[reward_ID].price <= balanceOf(msg.sender), "Insufficient Balance");
        require(reward_ID >= 0 && reward_ID <= 2, "Invalid reward ID");

        redeemedItems[msg.sender].push(Reward[reward_ID].name);
        _burn(msg.sender, Reward[reward_ID].price);
        return Reward[reward_ID].name;
    }

    function getRedeemedItems(address user) external view returns (string[] memory) {
        return redeemedItems[user];
    }
}
