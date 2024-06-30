// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract DegenGaming {
    address public commandCenter;

    // Token details
    string public tokenName = "Degen";
    string public symbol = "DGN";
    uint public totalSupply = 0;

    // Constructor to initialize the contract
    constructor() {
        commandCenter = msg.sender;
        rewards[0] = NFT("Emerald Boots", 2);
        rewards[1] = NFT("Emerald Sword", 3);
        rewards[2] = NFT("Identity Change Card", 5);
    }

    // Modifier to allow only owner to mint the tokens
    modifier onlyOwner() {
        require(msg.sender == commandCenter, "Only the command center can mint new tokens");
        _;
    }

    // Mapping to store balances and rewards
    mapping(address => uint256) private balances;
    mapping(uint256 => NFT) public rewards;
    mapping(address => string[]) public redeemedItems;

    // Struct to represent an NFT reward
    struct NFT {
        string name;
        uint256 price;
    }

    // Function to mint new tokens
    function mint(uint256 amount, address receiver) external onlyOwner {
        require(amount > 0, "Minting amount should be greater than 0");
        totalSupply += amount;
        balances[receiver] += amount;
    }

    // Function to transfer tokens
    function transfer(uint256 amount, address receiver) external {
        require(amount <= balances[msg.sender], "Insufficient balance to transfer");
        balances[receiver] += amount;
        balances[msg.sender] -= amount;
    }

    // Function to burn tokens
    function burn(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance to burn");
        balances[msg.sender] -= amount;
    }

    // Function to check the balance of a specific address
    function checkBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // Function to redeem rewards using tokens
    function redeem(uint256 rewardId) external returns (string memory) {
        require(rewardId >= 0 && rewardId <= 2, "Invalid reward ID");
        require(rewards[rewardId].price <= balances[msg.sender], "Insufficient balance to redeem reward");
        
        redeemedItems[msg.sender].push(rewards[rewardId].name);
        balances[msg.sender] -= rewards[rewardId].price;
        return rewards[rewardId].name;
    }

    // Function to get the list of redeemed items for a specific user
    function getRedeemedItems(address user) external view returns (string[] memory) {
        return redeemedItems[user];
    }
}
