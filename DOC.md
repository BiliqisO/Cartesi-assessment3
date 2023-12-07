# MyToken

MyToken is a smart contract that implements the ERC1155 standard for creating and managing multiple token types. It defines three types of tokens: Avatar, Gold, and Silver. Each token has a unique ID and a supply. The contract also enforces some custom rules for transferring the tokens.

## Functionality

The contract has the following functionality:

- constructor(address[] memory \_players): This is the constructor function that is executed when the contract is deployed. It takes an array of addresses as an argument and assigns each address an Avatar token, a Gold token with 10^6 supply, and a Silver token with 10^9 supply. The function uses the \_mintBatch function from the ERC1155 contract to mint the tokens in batches. The function also checks that each address does not already have an Avatar token, to prevent duplicate players.

- \_update(address from, address to, uint256[] memory ids, uint256[] memory values): This is an internal function that overrides the \_update function from the ERC1155 contract. It is called whenever a token transfer is initiated. It takes the sender address, the receiver address, an array of token IDs, and an array of token amounts as arguments. The function implements the following custom rules:

  - If the sender address is not the zero address, meaning that the transfer is not a minting operation, then the function checks the following conditions for each token ID:
    - If the token ID is 1, meaning that it is an Avatar token, then the function reverts the transfer, because Avatar tokens are soulbound and cannot be transferred.
    - If the receiver address does not have an Avatar token, then the function reverts the transfer, because only Avatar owners can receive other tokens.
    - If the sender address does not have an Avatar token, then the function reverts the transfer, because only Avatar owners can send other tokens.
  - If all the conditions are met, the function calls the super \_update function to execute the transfer.

## Usage

To use the contract, you will need the following:

- A web3 provider such as MetaMask, Infura, or Alchemy.
- A web3 client such as web3.js, ethers.js, or web3.py.
- A user interface such as a web app, a mobile app, or a CLI.

The usage steps are as follows:

- Connect to a web3 provider and choose a network (mainnet, testnet, or local).
- Interact with the contract using the web3 client and the user interface. You can perform the following actions:
  - Query the token balances of any address using the balanceOf function from the ERC1155 contract. The function takes an address and a token ID as arguments and returns the token amount.
  - Transfer any token (except Avatar) to another address using the safeTransferFrom function from the ERC1155 contract. The function takes the sender address, the receiver address, the token ID, the token amount, and an optional data as arguments and emits a TransferSingle event. The function also calls the \_update function to check the custom rules before executing the transfer.
  - Transfer multiple tokens (except Avatar) to another address using the safeBatchTransferFrom function from the ERC1155 contract. The function takes the sender address, the receiver address, an array of token IDs, an array of token amounts, and an optional data as arguments and emits a TransferBatch event. The function also calls the \_update function to check the custom rules before executing the transfer.
  - Approve another address to transfer your tokens on your behalf using the setApprovalForAll function from the ERC1155 contract. The function takes an operator address and a boolean value as arguments and emits an ApprovalForAll event. The function also updates the internal mapping of operators for the caller address.
  - Check if another address is approved to transfer your tokens on your behalf using the isApprovedForAll function from the ERC1155 contract. The function takes an owner address and an operator address as arguments and returns a boolean value. The function also checks the internal mapping of operators for the owner address.
