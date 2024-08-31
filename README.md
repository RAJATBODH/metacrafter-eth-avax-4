# Degen Gaming

**A smart contract for managing gaming tokens and rewards on the Ethereum blockchain.**

## Description

Degen Gaming is a Solidity-based smart contract that facilitates the minting, transferring, and burning of Degen tokens (DGN). Users can redeem their tokens for rewards, such as NFTs, and the contract includes functionalities for checking token balances and viewing redeemed rewards.

## Getting Started

### Installation

1. **Clone the Repository**
   - Clone the repository from GitHub using the command:
     ```bash
     git clone <repository-url>
     ```

2. **Set Up Solidity Environment**
   - Ensure that you have a Solidity-compatible development environment installed, such as:
     - [Remix IDE](https://remix.ethereum.org/)
     - [Truffle](https://www.trufflesuite.com/)
     - [Hardhat](https://hardhat.org/)

### Executing the Program

1. **Compile the Contract**
   - Use your Solidity-compatible environment to compile the smart contract.
   - Example using `solc` (Solidity compiler):
     ```bash
     solc DegenGaming.sol
     ```

2. **Deploy the Contract**
   - Deploy the contract on your desired Ethereum network using your preferred tool (e.g., Remix IDE, Truffle, Hardhat).

### Example Commands

- **To Compile the Contract:**
  ```bash
  solc DegenGaming.sol
  ```

- **To Deploy the Contract:**
  - Use Remix IDE or any other compatible environment to deploy the contract.

## Help

If you encounter common issues:

- **Solidity Version:** Ensure your Solidity compiler is updated to version 0.8.26 or later.
- **Gas Fees:** Verify that your wallet has sufficient ETH to cover gas fees during deployment and interactions with the contract.
- **Additional Help:**
  ```bash
  solc --help
  ```

## Authors

- **Rajat Bodh**

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

---

## Solidity Code

```solidity
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

    // Modifier to allow only owner to mint tokens
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
```

This updated version is more structured and clear, with consistent formatting and instructions that are easier to follow.
