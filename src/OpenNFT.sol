// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "solmate/tokens/ERC721.sol";
import "./GenerativeNFT.sol";
import "base64/base64.sol";

contract OpenNFT is ERC721, GenerativeNFT {
    uint256 public currentTokenId;

    constructor() ERC721("Open NFT", "OPEN") {}

    function mintTo(
        address recipient,
        string memory accountName,
        string memory repositoryName,
        uint16 prId,
        string memory prTitle,
        string memory author,
        string memory commitHash,
        uint16 linesAdded,
        uint16 linesRemoved,
        string memory primaryLanguage,
        string memory repositoryStarsCount
    ) public payable returns (uint256) {
        uint256 newItemId = ++currentTokenId;
        achievements[newItemId] = MetaData(
            accountName,
            repositoryName,
            prId,
            prTitle,
            author,
            commitHash,
            linesAdded,
            linesRemoved,
            primaryLanguage,
            repositoryStarsCount
        );
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"OpenNFT",',
                                '"image":"data:image/svg+xml;base64,',
                                Base64.encode(bytes(generateSVG(tokenId))),
                                '", "description": "Open source PRs freshly minted as NFTs",',
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
