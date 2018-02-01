# Upgradable Smart Contract
The smart contracts once written on blockchain can never be altered. But in some cases we ned to upgrade our code (may be a bug needs to be fixed or change some logic). I have tried implementing a system for upgradable erc-20 token.

**Note: In this Poc we can only upgrade the logic of the smart contract. We can not add/remove any function or the function paramteres or return agruments. Simply we can't change abi of our smart contract.** 

#### What exactly this project does?
The project is basically has a transfer function of an erc-20 token (Rest functionalities will be implemented over time). We can upgrade the logic of transfer without affetcing our contract.

## Architecture:
I have broken down the smart contract in 3 parts:
- **Main Contract:** This is the contract from which our users will be interacting. It internally calls functions of LogicLayer.sol which can be upgraded anytime.
- **DataLayer Contract**: This contract has all the state variables along with their getters and setters. The data is separated from Logic so that when we upgrade our logic, we do not loose our data.
- **LogicLayer Contract**: This contract main logic for transferring tokens. THis can only be called from main contract. It will use DataLayer contract to read/write data to/from blockchain.
 
## Get started !
- Deploy **Main.sol**
- Deploy **DataLayer.sol** with arguments totalSupply, decimalUints, TokenName and TokenSymbol
- Deploy **LogicLayer.sol** and pass the address of DataLayer in constructor.
- Call **upgradeLogicLayer** function of Main.sol and pass address of LogicLayer contract as function argument. This is to let our Main contract know where it needs to route the calls.
- Call **upgradeLogicLayer** function of DataLayer.sol and pass address of LogicLayer contract as function argument. This is to let our dataLayer know which contract can access it's methods. This method can only be called by owner of DataLayer contarct. 
- Now you can call tarnsfer function of main.sol to transfer token from one account to other.
 ##### Upgrading Logic:
- Now you may the logic of transfer function anytime you want. Just change the code inside `transfer` function without changing the abi of `LogicLayer.sol`. 
- Once you change the logic and deploy the new **LogicLayer**, you need to call `upgradeLogicLayer` method of **Main Contract and DataLayer Contract** passing the new address of LogicLayer.
- Again call the transfer function of `Main Contract` and you can see the contract has adapted to the change.

## Wana help?
The project is only for learning. This may have security issues/loopholes. I will try to figure out if this approach has some limitation/vulnerability. If you find anything that may help to improve the project, you are most welcome. Do let me know how can this be made better. **Cheers!**

