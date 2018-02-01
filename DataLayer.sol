pragma solidity ^0.4.17;

import "./LogicLayer.sol";

contract DataLayer {

	mapping (address => uint) balanceOf;
	uint totalSupply;
	uint decimals;
	string tokenName;
	string symbol;
	address ownerOfDataLayer;
	address latestLogicLayerContract;
	
	modifier isLatestLogicLayer{
	    require(msg.sender == latestLogicLayerContract);
	    _;
	}
	
	modifier isOwnerOfDataLayer{
	    require(msg.sender == ownerOfDataLayer);
	    _;
	}

	event Transfer(address indexed from, address indexed to, uint256 value);

	function DataLayer (uint _totalSupply, uint _decimals, string _name, string _symbol) public {
		totalSupply = _totalSupply;
		decimals = _decimals;
		tokenName = _name;
		symbol = _symbol;
		ownerOfDataLayer = msg.sender;
		balanceOf[msg.sender] = _totalSupply;
	}
	
	function upgradeLogicLayerContract(address _newLogicLayerContractAddress) public isOwnerOfDataLayer{
	    latestLogicLayerContract = _newLogicLayerContractAddress;
	}

	// setter of  balance
	function setBalance (address _account, uint _amount) external isLatestLogicLayer returns(uint) {
		balanceOf[_account] = _amount;
	}
	
	// getter of balance
	function getBalance (address _account) view  external isLatestLogicLayer  returns(uint) {
		return balanceOf[_account];
	}

	// firing Transfer Event
	function  fireTransferEvent (address _from, address _to, uint _amount) external isLatestLogicLayer {
		Transfer(_from, _to, _amount);
	}
	
}

