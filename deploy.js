require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/zaONfxS9o62es96pxpJi2gN8DzRrJJKZ", // you get from alchemy
      accounts: ["0x31ae3fb74217bd082de43490d738f220637809259b7116e29160582406270386"] // MetaMask private key for deplyer
    }
  }
};
