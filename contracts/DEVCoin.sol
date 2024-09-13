// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.27;

//Interface ERC20
interface IERC20 {
    //functions
    function totalSupply() external view returns(uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    //events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//Smart Contract Simple DEV Coin
contract DEVCoin is IERC20 {

    //ATRIBUTES
    //The name and the token of DEV Coin - the Currency of the IT professional
    string public constant name = "DEV Coin";
    string public constant symbol = "DEV";
    uint public constant decimals = 10;

    mapping(address => uint256) balances;
    mapping(address => mapping(address=>uint256)) allowed;

    // The supply of the DEV Coin is the same of Bitcoin
    uint256 totalSupply_ = 21000000;

    //the connstructor of smart contract
    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    //METHODS
    //return the total supply os DEV Coin
    function totalSupply() public override view returns(uint256) {
        return totalSupply_;
    }

    //return the balance of the owner contract
    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    //transfer a amount of tokens for a specific address
    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    // approve the transfer a amount of tokens for a address
    function approve(address delegate, uint256 numTokens) public override returns (bool){
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    // return the allowance disponible for a address
    function allowance(address owner, address delegate) public override view returns (uint256){
        return allowed[owner][delegate];
    }

    // tranfer a amount of tokens of the owner account to the buyer occount
    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}