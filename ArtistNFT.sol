// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Code format based on this tutorial:
// https://www.quicknode.com/guides/ethereum-development/nfts/how-to-create-and-deploy-an-erc-721-nft
// I changed some parts to fit my own artist leaderboard idea.
// I also used parts of ERC721.sol and BallotV4.sol from class examples.

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ArtistNFT is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    // This struct stores the artist's name and how many votes they got
    struct Artist {
        string name;
        uint256 voteCount;
    }

    // This maps token ID to the artist info
    mapping(uint256 => Artist) public artists;

    constructor() ERC721("ArtistNFT", "ARTY") {}

    // This function lets anyone mint a new artist NFT
    // Based on the QuickNode video mint() function, but without onlyOwner
    function mintArtist(string memory name) public returns (uint256) {
        uint256 newId = _tokenIds.current();

        _mint(msg.sender, newId); // Give NFT to the person calling this
        artists[newId] = Artist(name, 0); // Set artist name and 0 votes
        _tokenIds.increment(); // Go to next ID

        return newId;
    }

    // This function lets anyone vote for an artist
    // Based on BallotV4 from class (simplified for this project)
    function vote(uint256 tokenId) public {
        require(_exists(tokenId), "This artist doesn't exist");
        artists[tokenId].voteCount++;
    }

    // This function lets you see the artist's name and their vote count
    function getArtist(uint256 tokenId) public view returns (string memory, uint256) {
        require(_exists(tokenId), "This artist doesn't exist");
        Artist memory a = artists[tokenId];
        return (a.name, a.voteCount);
    }
}
