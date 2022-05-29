// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "solmate/tokens/ERC721.sol";

contract GenerativeNFT {
    // Mapping from tokenId to metadata.
    mapping(uint256 => MetaData) public achievements;

    struct MetaData {
        // Github account name.
        string accountName;
        // Github respository name.
        string repositoryName;
        // Pull request ID.
        uint16 prId;
        // The title of the pull request submitted.
        string prTitle;
        // Author (Github username) of the person who submitted the PR.
        string author;
        // Github commit hash.
        string commitHash;
        // Stats: Number of lines added.
        uint16 linesAdded;
        // Stats: Number of lines removed.
        uint16 linesRemoved;
        // Stats: Primary programming language used in the PR
        string primaryLanguage;
        // Stats: Star count of repository at the time of mint, could be automated?
        string repositoryStarsCount;
    }

    function generateSVG(uint256 tokenId)
        public
        view
        returns (bytes memory svg)
    {
        MetaData memory data = achievements[tokenId];

        // bytes are encoded in multiple segments to prevent Stack too deep when compiling inline assembly
        return
            bytes.concat(
                abi.encodePacked(
                    '<?xml version="1.0" encoding="UTF-8"?>'
                    '<svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="0 0 1024 1024" width="1024" height="1024">'
                    "   <defs>"
                    '      <linearGradient id="P" gradientUnits="userSpaceOnUse" />'
                    '      <linearGradient id="g1" x1="641.6" y1="880" x2="641.6" y2="4.2" href="#P">'
                    '         <stop stop-color="#060708" />'
                    '         <stop offset=".3" stop-color="#121c13" />'
                    '         <stop offset=".5" stop-color="#1f3420" />'
                    '         <stop offset=".8" stop-color="#315531" />'
                    '         <stop offset="1" stop-color="#7ada78" />'
                    '         <stop offset="1" stop-color="#7ada78" />'
                    "      </linearGradient>"
                    '      <image width="1098" height="1014" id="img1" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABEoAAAP2AQMAAADKJ+ojAAAAAXNSR0IB2cksfwAAAANQTFRFAAAAp3o92gAAAJ9JREFUeJztwTEBAAAAwqD1T20JT6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4GkmsAABH2E0LQAAAABJRU5ErkJggg==" />'
                    '      <image width="44" height="44" id="img2" href="data:image/png;base64,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" />'
                    '      <filter x="-50%" y="-50%" width="200%" height="200%" id="f1">'
                    '         <feDropShadow dx="0" dy="0" stdDeviation="17.917" flood-color="#fefefe" flood-opacity=".4" />'
                    "      </filter>"
                    "   </defs>"
                    "   <style><![CDATA[tspan{white-space:pre;}.bw{word-wrap: break-word; width:1000px}.d{fill:#878787;font-weight:400;font-family:&quot;Roboto-Regular&quot;,&quot;Roboto&quot;}.d,.e{font-size:22px}.e,.h,.j,.k,.l,.m{font-weight:400;font-family:&quot;Roboto-Regular&quot;,&quot;Roboto&quot;}.e{fill:#b9b9b9}.h{font-size:29px;fill:#878787}.j{font-size:25px;fill:#7ada78}.k{font-size:30px}.k,.l,.m{fill:#fff}.l{font-size:20px}.m{font-size:62px}]]></style>"
                    '   <use href="#img1" />'
                    '   <rect x="177" y="98" width="726" height="782" rx="27" style="filter:url(#f1);fill:url(#g1)" />'
                    '   <rect x="205.6" y="116.9" width="669.4" height="502.1" rx="27" style="fill:#323232" />'
                    '   <path d="M250 542.9v-5h580.5v5z" style="fill:#636363" />'
                    '   <text style="transform:matrix(1,0,0,1,255,588)">'
                    '      <tspan x="0" y="0" class="d">Commit</tspan>'
                    "   </text>"
                    "   <!-- Additions -->"
                    '   <text style="transform:matrix(1,0,0,1,303,502)">'
                    '      <tspan x="0" y="0" class="h">',
                    data.linesAdded,
                    "      </tspan>"
                    "   </text>"
                    "   <!-- Subtraction -->"
                    '   <text style="transform:matrix(1,0,0,1,416,502)">'
                    '      <tspan x="0" y="0" class="h">',
                    data.linesRemoved,
                    "      </tspan>"
                    "   </text>"
                    "   <!-- Account Name -->"
                    '   <text style="transform:matrix(1,0,0,1,253,681)">'
                    '      <tspan x="0" y="0" class="h">',
                    data.accountName,
                    "      </tspan>"
                    "   </text>"
                ),
                abi.encodePacked(
                    "   <!-- Github Stars -->"
                    '   <text style="transform:matrix(1,0,0,1,250,820)">'
                    '      <tspan x="0" y="0" class="h">&#11088;',
                    data.repositoryStarsCount,
                    "      </tspan>"
                    "   </text>"
                    '   <path d="M379 790h110v40H379z" style="fill:none;stroke:#d2f43b;stroke-linecap:round;stroke-linejoin:round" />'
                    "   <!-- Language -->"
                    '   <text style="transform:matrix(1,0,0,1,393,798)">'
                    '      <tspan x="0" y="18.8" class="j">',
                    data.primaryLanguage,
                    "      </tspan>"
                    "   </text>"
                    "   <!-- Pull request ID -->"
                    '   <text style="transform:matrix(1,0,0,1,267,197)">'
                    '      <tspan x="0" y="0" class="k">#',
                    data.prId
                ),
                abi.encodePacked(
                    "</tspan>"
                    "   </text>"
                    '   <use href="#img2" x="572" y="469" />'
                    "   <!-- Author -->"
                    '   <text style="transform:matrix(1,0,0,1,627,499)">'
                    '      <tspan x="0" y="0" class="l">',
                    data.author,
                    "      </tspan>"
                    '      <tspan y="0" class="l" />'
                    "   </text>"
                    '   <text style="transform:matrix(1,0,0,1,254,732)">'
                    '      <tspan x="0" y="0" class="k">',
                    data.repositoryName,
                    "      </tspan>"
                    '      <tspan y="0" class="k" />'
                    "   </text>"
                    '   <text style="transform:matrix(1,0,0,1,254,290)">'
                    '      <tspan x="0" y="0" class="m">',
                    data.prTitle,
                    "      </tspan>"
                    "   </text>"
                    '   <text style="transform:matrix(1,0,0,1,720,780)" font-size="120px">'
                    "     &#128737;"
                    "   </text>"
                    "</svg>"
                )
            );
    }
}
