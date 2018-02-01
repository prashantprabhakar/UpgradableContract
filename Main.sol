pragma solidity ^0.4.17;

import "./LogicLayer.sol"

contract Main{
    
    address public owner;
    LogicLayer logicLayer;
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function Main() public {
        owner = msg.sender;
    }
    
    function upgradeLogicLayerContract(address _logicLayerAddress) public onlyOwner returns(bool){
        logicLayer = LogicLayer(_logicLayerAddress);
        return true;
        // kill the previous contract
    }
    
    function transfer(address _to, uint _amount) public {
        logicLayer.transfer(msg.sender, _to, _amount);
    }
    
    function getBalance(address _account) public view returns (uint){
        return logicLayer.getBalance(_account);
    }
}

