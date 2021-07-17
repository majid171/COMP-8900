// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract PrivacyPreservingDelivery {

    address owner;
    address deliveryAgent;

    //3
    mapping(string => string) public deliveryAddress;
    
    modifier restricted(string memory agentAddress) {
        require(msg.sender == deliveryAgent);
        _;
    }
    
    //0
    constructor(string memory fullAddress) {
        owner = msg.sender;
        
        // There will be a standard in terms of the order in which the address is supplied
        // Country, Province, City, Street Name, Street Number, Postal Code, Unit Number
    }
    
    //2
    function registerDeliveryAgent() public {
        // ...
    }
    
    //1
    function getNextAddressPiece(string memory deliveryAgentAddress) public restricted(deliveryAgentAddress){
        // ...
    }
    
    //to-do
    // function getDeliveryAgents(ordernumber) public view returns (DeliveryAgent memory){
    //     if(ordernumber == this.ordernumber) return deliveryAgent;
    // }
}
