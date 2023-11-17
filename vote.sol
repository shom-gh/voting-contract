// SPDX-License-Identifier: MIT
pragma solidity >=0.7 <0.9.0;

contract Voting {

    struct Candidate {
        string name;
        uint32 votes;
        bool isRegistered;
    }
    

    mapping(address => Candidate) candidates;
    address[] registered;

    function register(string memory name) public {
        // regirster and recieve 10 votes
        require(!candidates[msg.sender].isRegistered, "address already exists");
        candidates[msg.sender] = Candidate(name, 10, true);
        registered.push(msg.sender);
    }

    function giveVote(address to) public {
        // give 1 vote to other candidate
        require(to != msg.sender, "cannot give to yourself");
        require(candidates[msg.sender].isRegistered, "you have to register first");
        require(candidates[to].isRegistered, "candidate is not registered");
        require(candidates[msg.sender].votes >= 0, "no more votes left");

        candidates[msg.sender].votes -= 1;
        candidates[to].votes += 1;
    }

    function mintVotes() public {
        // gives 10 votes to caller
        require(candidates[msg.sender].isRegistered, "you have to register first");
        candidates[msg.sender].votes += 10;
    }

    function burnVotes() public {
        // burns 10 votes
        require(candidates[msg.sender].isRegistered, "you have to register first");
        require(candidates[msg.sender].votes >= 10, "not enough votes to burn");
        candidates[msg.sender].votes -= 10;
    }

    function getCandidate(address addr) public view returns(Candidate memory) {
        require(candidates[addr].isRegistered, "candidate is not registered");
        return candidates[addr];
    }

    function getAllRegistered() public view returns (address[] memory) {
        return registered;
    }

}