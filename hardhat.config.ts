import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";
require("dotenv").config();
const { MAINNET_RPC, SEPOLIA_RPC, ETHERSCAN_API, PRIVATE_KEY1 } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC,
      accounts: [PRIVATE_KEY1!],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API,
  },
};

export default config;
