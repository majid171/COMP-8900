// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract PrivacyPreservingDelivery {

    address owner;
    address deliveryAgent;
    mapping(string => string) public deliveryAddress;
    
    modifier restricted(string memory agentAddress) {
        require(msg.sender == deliveryAgent);
        _;
    }
    
    constructor(string[] memory fullAddress) {
        owner = msg.sender;
        deliveryAddress["Country"] = fullAddress[0];
        deliveryAddress["Province"] = fullAddress[1];
        deliveryAddress["City"] = fullAddress[2];
        deliveryAddress["StreetName"] = fullAddress[3];
        deliveryAddress["StreetAddress"] = fullAddress[4];
        deliveryAddress["PostalCode"] = fullAddress[5];
        deliveryAddress["UnitNumber"] = fullAddress[6];    
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
