// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract SimpleERC1155 is ERC1155 {
    uint256 public constant TOKEN_ID = 1;
    uint256 public totalSupply;

    constructor() ERC1155("https://example.com/api/item/{id}.json") {
        totalSupply = 0;
    }

    function mint(uint256 amount) public {
        totalSupply += amount;
        _mint(msg.sender, TOKEN_ID, amount, "");
    }
}
