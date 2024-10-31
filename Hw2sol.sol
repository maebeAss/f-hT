// SPDX-License-Identifier: GPL-3.0 
 
pragma solidity >=0.8.2 <0.9.0; 
 
contract Hw2sol { 
 
    uint balance;
 
    constructor () { 
        balance = 0;
        bibaDatabase;
    } 
 
    modifier onlyOwnerOfBiba { 
        require(bibaDatabase[msg.sender].ownerOfBiba == msg.sender, "intruder, not owner"); 
        _; 
    } 
 
    struct Biba { 
        string name; 
        uint age; 
        uint balance;
        bool created;
        address ownerOfBiba;
    } 
    mapping (address => Biba) bibaDatabase; 
 
    function createNewBiba (string memory _name, uint _age) public {
        require(bibaDatabase[msg.sender].created == false, "Only one single Biba per person");
        bool _created = true;
        uint _balance = balance;
        address _ownerOfBiba = msg.sender;
        bibaDatabase[msg.sender] = Biba(_name, _age, _balance, _created, _ownerOfBiba);
    }
 
    function getAnyInfoBiba (address _addr) public view returns (string memory, uint, uint) {
        return  (bibaDatabase[_addr].name, bibaDatabase[_addr].age, bibaDatabase[_addr].balance);
    }

    function depositYourBiba (address _addr) public payable onlyOwnerOfBiba { 
        require(msg.value >= 0.0001 ether, "Minimum deposit is 0.0001 ETH"); 
        (bool sent, ) = address(0).call{value:msg.value}("");
        bibaDatabase[_addr].balance += msg.value;
    }

    function sendFromYourBiba (address _to, uint _amount) public onlyOwnerOfBiba {
        require(bibaDatabase[msg.sender].balance >= _amount, "autism");
        require(msg.sender != _to, "you're not that tricky");
        bibaDatabase[msg.sender].balance -= _amount;
        bibaDatabase[_to].balance += _amount;
    }

    // function SendEth (uint _amount, address payable _to) public payable onlyOwner returns (string memory _message) { 
    //     require(bibaDatabase[owner].balance == _amount, "not enough balance"); 
    //     require(_to != address(0)); 
    //     _to.transfer(_amount); 
    //     _message = "Transaction proceeded"; 
    //     return (_message); 
    // } 
 
}
