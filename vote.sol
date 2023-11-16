// SPDX-License-Identifier: MIT
pragma solidity >=0.7 <0.9.0;

contract Voting {

    struct Candidate {
        address addr;
        string name;
        uint8 votes;
        bool isRegistered;
    }
    
    mapping(address => Candidate) candidates;
    address[] registered;

    function register(string memory name, address addr) public {
        if (candidates[addr].isRegistered) {
            revert("already registered");
        }
        candidates[msg.sender] = Candidate(msg.sender, name, 10, true);
        registered.push(msg.sender);
    }

    function vote(address voteFor) public {
        if (voteFor == msg.sender) {
            revert("cannot give vote to yourself");
        }
        if (!candidates[msg.sender].isRegistered) {
            revert("you have to register first");
        }
        if (candidates[msg.sender].votes >= 0) {
            revert("no more votes left");
        }
        candidates[msg.sender].votes -= 1;
        candidates[voteFor].votes += 1;
    }

    functoin getCandidates() public returns address[]
        return registered


}