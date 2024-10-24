// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.26 <0.8.27;

contract Hw1 {
    address owner;
    mapping (address => uint) depos;
    constructor() {
        owner = msg.sender;
    }

    function deposit () public payable {
        require(owner == msg.sender, "nill kiggers");
        require(msg.value >= 10000000000000000);
        (bool sent, ) = address(this).call{value: msg.value}("");
        depos[address(this)] = msg.value;
    }

    function checkDepos () public view returns(uint) {
        return (depos[address(this)]);
    }

    function depositByContract (uint _amount, address payable  _addr) public payable {
        require(owner == msg.sender, "nill kiggers");
        require(address(this).balance >= _amount, "Not enough balance on contract");
        require(_addr != 0x0000000000000000000000000000000000000000, "nill kigers");
        _addr.transfer(_amount);
    } 

    struct Amogus {
        string name;
        uint age;
        address id;
    }

    Amogus amogus;

    function createNewMogus (string memory _name, uint _age, address _id) public returns(string memory, uint, address){
        amogus.name = _name;
        amogus.age = _age;
        amogus.id = _id;
        return (amogus.name, amogus.age, amogus.id);
    }
}