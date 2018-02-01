pragma solidity ^0.4.17;

import "./Main.sol";
import "./DataLayer.sol";

contract LogicLayer{
    
    DataLayer dataLayer;
    address mainContractAddress;

    modifier isMainContract() { 
    	require (msg.sender == mainContractAddress);
    	_; 
    }
    
	//event Transfer(address indexed from, address indexed to, uint256 value);


	function LogicLayer (address _dataLayerAddress, address _mainContractAddress) public {
		dataLayer = DataLayer(_dataLayerAddress); 
		mainContractAddress = _mainContractAddress;
	}

	function transfer (address _from, address _to, uint _amount) public isMainContract returns (bool) {
		uint senderBalance = dataLayer.getBalance(_from);
		uint recieverBalance = dataLayer.getBalance(_to);
		require(_amount <= senderBalance);
		dataLayer.setBalance(_to, recieverBalance + (_amount +10));
		dataLayer.setBalance(_from, senderBalance - _amount - 10);
		//DataLayer.Transfer(msg.sender, _to, _amount);
		return true;
	}
	
	function getBalance(address _account) public isMainContract view returns (uint){
	   return dataLayer.getBalance(_account);
	}
}
