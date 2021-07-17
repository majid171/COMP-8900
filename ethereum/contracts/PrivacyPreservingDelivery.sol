// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract PrivacyPreservingDelivery {
   
    struct DeliveryAgent{
        string name;
        address agentAddress;
    }
   
    address owner;
    mapping(string => string) public deliveryAddress;
    DeliveryAgent deliveryAgent;
    
    modifier restricted(string agentName) {
        require(msg.sender == deliveryAgent.agentAddress);
        require(agentName == deliveryAgent.name);
        _;
    }
    
    constructor(string fullAddress) public {
        owner = msg.sender;
        
        // There will be a standard in terms of the order in which the address is supplied
        // Country, Province, City, Street Name, Street Number, Postal Code, Unit Number
    }
    
    function registerDeliveryAgent() public {
        // ...
    }
    
    function getNextAddressPiece(string deliveryAgentName) public restricted{
        // ...
    }
    
    function getDeliveryAgents() public {
        // ...
    }
}
