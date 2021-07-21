// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract PrivacyPreservingDelivery {

    enum Stages {
        InitialCommit,
        FirstReveal,
        SecondReveal,
        ThirdReveal,
        FourthReveal,
        Delivered
    }
    
    struct CommitChoice {
        string commitment;
        uint64 block;
        bool revealed;
    }
    
    address owner;
    CommitChoice[] public commits;
    Stages stage;
    uint64 commitIndex;
    
    modifier restricted() {
        require(msg.sender == owner);
        _;
    }
    
    constructor(string memory dataHash1, string memory dataHash2, string memory dataHash3, string memory dataHash4) {
        owner = msg.sender;
        stage = Stages.InitialCommit;
        commitIndex = 0;
        
        commit(dataHash1);
        commit(dataHash2);
        commit(dataHash3);
        commit(dataHash4);
        
        stage = Stages.FirstReveal;
    }
    
    function commit(string memory dataHash) public restricted{
        
        require(stage == Stages.InitialCommit);
        
        CommitChoice memory commitChoice = CommitChoice(dataHash, uint64(block.number), false);
        commits.push(commitChoice);
    }
    
    function reveal() public payable returns(string memory){
        require(stage == Stages.FirstReveal || stage == Stages.SecondReveal || stage == Stages.ThirdReveal || stage == Stages.FourthReveal);
        require(commitIndex < commits.length);
        require(commits[commitIndex].revealed == false);
        
        commits[commitIndex].revealed = true;
        
        if(stage == Stages.FirstReveal) stage = Stages.SecondReveal;
        else if(stage == Stages.SecondReveal) stage = Stages.ThirdReveal;
        else if(stage == Stages.ThirdReveal) stage = Stages.FourthReveal;
        else if(stage == Stages.FourthReveal) stage = Stages.Delivered;
        
        return commits[commitIndex++].commitment;
    }
}
