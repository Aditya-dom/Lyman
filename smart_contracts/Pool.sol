// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./Token.sol";

contract Pool {
    using SafeMath for uint256;

    Token public tokenA;
    Token public tokenB;
    address constant FEE_ADDRESS = 0xYourFeeAddressHere;

    constructor(address _tokenAAdr, address _tokenBAdr) public {
        tokenA = Token(_tokenAAdr);
        tokenB = Token(_tokenBAdr);
    }

    // Implement pool functions such as adding/removing liquidity and 
swapping tokens.
}