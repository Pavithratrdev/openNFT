// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "solmate/tokens/ERC721.sol";
import "./GenerativeNFT.sol";

contract NFT is ERC721, GenerativeNFT {
    uint256 public currentTokenId;

    constructor() ERC721("Open NFT", "OPEN") {}

    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return string(abi.encodePacked("data:application/json;base64,"));
    }
}
