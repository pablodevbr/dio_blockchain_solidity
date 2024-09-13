// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//Smart Contract simple for a voting
contract DIOVoting {
    //ATTRIBUTES
    mapping (string => uint256) public votesReceived;

    string[] public candidateList;

    constructor (string[] memory candidateNames){
        candidateList = candidateNames;
    }

    //METHODS
    //return the number of votes for a candidate
    function totalVotesFor(string memory candidate) view public returns (uint256) {
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    //add a vote for a specific candidate
    function votesForCandidate(string memory candidate) public {
        require(validCandidate(candidate));
        votesReceived[candidate]++;
    }

    //valid if a candidate is participating in a election
    function validCandidate(string memory candidate) view public returns(bool) {
        for(uint i=0;i<candidateList.length;i++){
            if(keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))) {
                return true;
            }
        }
        return false;
    }
}