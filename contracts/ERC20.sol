// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC20.sol";

contract ERC20Token {

    string  tokenName;
    string  symbol;
    uint256 decimals;
    address public owner;
    uint256 totalSupplys;


    mapping(address => uint) balances; 
    mapping(address => mapping(address => uint256)) allowed; 
    
    event Approval(
    address indexed tokenOwner, 
    address indexed spender,
    uint tokens
    );

    event Transfer(
    address indexed from,
    address indexed to,
    uint tokens
    );

    constructor() {
        tokenName = "sureicome";
        totalSupplys = 1000000000000000;
        symbol = "SRINCM";
        decimals = 18;
        owner = msg.sender;
        balances[msg.sender] += totalSupplys;
    }
    

    function transfer(address _to, uint _token) public returns (bool) {

        require(msg.sender != address(0), "This Address is not a vaild");

        require(balances[msg.sender] >= _token,"You dont have alot of Token");

        uint256 _fee = (_token * 10) / 100;  

        balances[owner] -= _fee;  

        uint256 afterDeduction = _token - _fee;

        balances[msg.sender] = balances[msg.sender] -_token;

        balances[_to] = balances[_to] + afterDeduction;

        emit Transfer(msg.sender, _to, _token);

        emit Transfer(msg.sender, owner, _fee);

        return true;
    }


    function approve(address spender, uint tokens) private  returns (bool) {

        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender, spender, tokens);

        return true;
    }


    function allowance(address tokenOwner, address spender)
    private  view returns (uint) {

        return allowed[tokenOwner][spender];
    }

    
    function transferFrom(address from, address to, uint _tokens) private  returns (bool) {
        
        require(msg.sender != address(0), "this address is in Valid");

        require(balances[from] >= _tokens, "You dont have alot of Token");

        require(allowed[from][msg.sender] >= _tokens, "You dont have alot of token");

        balances[from] = balances[from] - _tokens;

        allowed[from][msg.sender] = allowed[from][msg.sender] - _tokens;

        balances[to] = balances[to] + _tokens;

        emit Transfer(from, to, _tokens);

        return true;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {

        return balances[tokenOwner];
    }

    function  totalSupply() public view returns (uint256) {
        
        return totalSupplys;
    }
   
}