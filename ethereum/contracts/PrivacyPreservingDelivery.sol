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
    
    modifier restricted(string memory agentName) {
        require(msg.sender == deliveryAgent.agentAddress);
        // require();
        _;
    }
    
    constructor(string memory fullAddress) {
        owner = msg.sender;
        
        // There will be a standard in terms of the order in which the address is supplied
        // Country, Province, City, Street Name, Street Number, Postal Code, Unit Number
    }
    
    function registerDeliveryAgent() public {
        // ...
    }
    
    function getNextAddressPiece(string memory deliveryAgentName) public restricted(deliveryAgentName){
        // ...
    }
    
    function getDeliveryAgents() public view returns (DeliveryAgent memory){
        return deliveryAgent;
    }
}
