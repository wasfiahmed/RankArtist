const hre = require("hardhat");

async function main() {
  // Deploy mock YODA token first
  const Yoda = await hre.ethers.getContractFactory("ERC20Mock");
  const yoda = await Yoda.deploy("YODA Token", "YODA");
  await yoda.deployed();

  // Deploy main contract
  const ArtistNFT = await hre.ethers.getContractFactory("ArtistNFT");
  const artistNFT = await ArtistNFT.deploy(yoda.address);
  
  console.log("YODA Token deployed to:", yoda.address);
  console.log("ArtistNFT deployed to:", artistNFT.address);

  // Fund test accounts
  const [owner, user1] = await hre.ethers.getSigners();
  await yoda.mint(owner.address, 100000); // 1000 YODA
  await yoda.mint(user1.address, 100000); // 1000 YODA
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
