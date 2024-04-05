// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC1155/extensions/ERC1155Supply.sol";

contract GameStop_Token is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {

    uint256 public constant GME = 0;

    uint256 public price = 100000000000000;
    string public name = "GameStop Token";
    string public symbol = "GME";


    constructor()
        ERC1155("ipfs://bafkreig2fcutcsqtjvyesb5qc36okdalhrgpr2ews7gowimgtrdpw3kr7u")
    {

        _mint(msg.sender, GME, 10, "");

    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function setPrice(uint256 newprice) public onlyOwner {
        price = newprice;
    }

    function mint(uint256 id, uint256 amount)
        public
        payable
    {
        require(id == 0, "Token ID does not exist");
        require(msg.value >= (amount * price), "Not enough ETH sent.");
        _mint(msg.sender, id, amount, "");
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}