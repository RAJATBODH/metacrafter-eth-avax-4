Degen Gaming 

A smart contract for managing gaming tokens and rewards on the Ethereum blockchain. 

Description 

Degen Gaming is a smart contract that allows the minting, transferring, and burning of Degen tokens (DGN). Users can also redeem their tokens for rewards such as NFTs. This contract includes functionality for checking balances and viewing redeemed items. 

Getting Started 

Installing 

Clone the repository from GitHub 

Ensure you have a Solidity-compatible environment set up (e.g., Remix IDE, Truffle, Hardhat) 

Executing Program 

Compile the contract using your Solidity-compatible environment 

Deploy the contract to your desired Ethereum network 

Example commands: 

// To compile the contract 
solc Degen_Gaming.sol 
// To deploy the contract (using Remix or other IDE) 
 

Help 

For common issues or questions: 

Ensure your Solidity compiler is updated to version 0.8.26 or later. 

Check that your wallet has sufficient ETH for gas fees when deploying and interacting with the contract. 


// If the program contains helper info 
solc --help 
 

Authors 

Rajat Bodh 

License 

This project is licensed under the MIT License - see the LICENSE.md file for details. 

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
