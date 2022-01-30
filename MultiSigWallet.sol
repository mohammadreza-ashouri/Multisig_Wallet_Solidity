// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;


contract MultiSigWallet{

//Events are used to inform external users that something happened on the blockchain
event Deposit(address indexed sender, uint amount);
address[] public walletowners;
mapping(address => bool) public isOwner; //isOwner is used to make sure that the caller of the method is the owner of the contract
//Mapping in Solidity acts like a hash table or dictionary in any other language
//These are used to store the data in the form of key-value pairs

uint public minimumrequired; // the minimum number if required approvals

}

struct Transaction{
    address to;
    uint value;
    bytes date;
    bool executed;
}

Transction[] public transactions; // we store all  the transactions in an array of Transaction

mapping(uint=> mapping(address =>bool)) public approved; // we want to check whether the number of approvals are greater or equal than the minimum 
//required to execute a transaction, so we store that in this mapping


constractor(address[] memory _owners, uint required){ // _owners type is memory because we use it as the function parameter to store data temporary and we wont store it on the blockchian,

    require(_owners.lenght >0, " no enough owners!"); // we need at least one owner
    require(_required > 0 && _required <= _owners.length, "invalid number of owners!");// the required must be less than or equal to the number of owners
    
    
    for(uint i; i < _owners.length; i++ ){
        address owner = _owners[i];
        require(owner != address(0), "invalid owner"); //  address(0) is a special address (burn address)

        require(!isOwner[owner], "owner is no unique"); // isOwner is often used to make sure that the caller of the method is the owner of the contract

        isOwner[owner] = true; 

        owners.push(owner); // owner is a state variable, Every smart contract is owned by an address called as owner
        //TIP: state variables whose values are permanently stored in a contract storage.
    }

    minimumrequired = required;
}


receive() external payable() { // other contracts can call this but internal functions cannot!

    emit Deposit(msg.sender,msg.value);  //msg.sender special global variable to obtain the current user’s address (e.g., 0x44d33a….) from where the function call came
}



}


