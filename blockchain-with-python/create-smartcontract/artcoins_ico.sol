Artcoins ICO

// Version of compiler
pragma solidity ^0.4.11;

contract artcoin_ico {

    // Introducing the maximum number of Artcoins available for sale
    uint public max_artcoins = 1000000;

    // Introducing the USD to Artcoins conversion rate
    uint public usd_to_artcoins = 1000;

    // Introducing the total number of Artcoins that have been bought by the investors
    uint public total_artcoins_bought = 0;

    // Mapping from the investor address to its equity in Artcoins and USD
    mapping(address => uint) equity_artcoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy Artcoins
    modifier can_buy_artcoins(uint usd_invested) {
        require (usd_invested * usd_to_artcoins + total_artcoins_bought <= max_artcoins);
        _;
    }

    // Getting the equity in Artcoins of an investor
    function equity_in_artcoins(address investor) external constant returns (uint) {
        return equity_artcoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buying Artcoins
    function buy_artcoins(address investor, uint usd_invested) external
    can_buy_artcoins(usd_invested) {
        uint artcoins_bought = usd_invested * usd_to_artcoins;
        equity_artcoins[investor] += artcoins_bought;
        equity_usd[investor] = equity_artcoins[investor] / 1000;
        total_artcoins_bought += artcoins_bought;
    }

    // Selling Artcoins
    function sell_artcoins(address investor, uint artcoins_sold) external {
        equity_artcoins[investor] -= artcoins_sold;
        equity_usd[investor] = equity_artcoins[investor] / 1000;
        total_artcoins_bought -= artcoins_sold;
    }

}