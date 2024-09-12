pragma solidity ^0.8.0;



interface IERC20{



    function totalSupply() external  view returns (uint256);



    function balanceOf(address account) external  view  returns (uint256);



    function allowance(address owner, address spender) external  view  returns (uint256);



    function transfer(address recipient, uint256 amount) external returns (bool);



    function approve(address spender, uint256 amount) external returns (bool);



    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);



    event Transfer(address indexed from, address indexed to, uint256 value);



    event Approval(address indexed owner, address indexed soender, uint256);



}


contract Samoeda1 is IERC20 {

    string public constant name = "samoeda1";
    string public constant symbol = "SAM";
    uint8 public  constant decimals = 18;



    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;



    uint256 totalSupply_ = 10 ether;



    constructor () {

        balances[msg.sender] = totalSupply_;

    }



    function totalSupply() public override  view returns (uint256) {

        return totalSupply_;

    }



    function balanceOf(address tokenOwner) public override  view returns (uint256) {

        return balances[tokenOwner];

    }



    function transfer(address receiver, uint256 numToken) public override  view returns (bool) {

        require(numToken <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender] - numToken;

        balances[receiver] = balances[receiver] + numToken;

        emit Transfer(msg.sender, receiver, numToken);

        return true;

    }



    function approve(address delegate, uint256 numToken) public  override  returns (bool) {

        allowed[msg.sender] [delegate] = numToken;

        emit Approval(msg.sender, delegate, numToken);

        return true;

    }



    function allowance(address owner, address delegate) public  override view  returns (uint256) {

        return allowed[owner] [delegate];

    }



    function transferFrom(address owner, address buyer, uint256 numToken) public  override  returns (bool) {

        require(numToken <= balances[owner]);

        require(numToken <= allowed[owner] [msg.sender]);



        balances[owner] = balances[owner] - numToken;

        allowed[owner] [msg.sender] = allowed[owner] [msg.sender] - numToken;

        balances[buyer] = balances[buyer] - numToken;

        emit Transfer(owner, buyer, numToken);

        return true;

       

    }



}