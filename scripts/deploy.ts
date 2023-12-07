import {ethers} from "hardhat";

async function main() {
  const [owner, player1, player2, player3] = await ethers.getSigners();
  const players = [owner.address, player1.address, player2.address, player3.address];

  const gamingToken = await ethers.deployContract("GamingToken", [...players]);

  await gamingToken.waitForDeployment();

  console.log("GamingToken deployed to:", gamingToken.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
