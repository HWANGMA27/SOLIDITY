// version of solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract vote {
    // structure
    struct candidator {
        string name;
        uint upvote;
    }

    // variable
    candidator[] public candidatorList;
    bool isLive;
    address owner;

    // mapping
    mapping(address => bool) Voted;

    // event
    event AddCandidator(string name);
    event UpVote(string candidatorName, uint upVote);
    event EndVote(bool isLive);
    event Voting(address owner);

    // modifier
    modifier isOwner {
        require(msg.sender == owner);
        _;
    }

    // constructor
    constructor() {
        owner = msg.sender;
        isLive = true;

        emit Voting(owner);
    }

    // candidator registration
    function registrationCandidator(string calldata _name) public isOwner {
        require(isLive == true);
        require(candidatorList.length < 5);
        candidatorList.push(candidator(_name, 0));

        // emit event
        emit AddCandidator(_name);
    }

    // vote
    function upVote(uint _indexOfCandidator) public {
        require(isLive == true);
        require(candidatorList.length > _indexOfCandidator);
        require(Voted[msg.sender] == false);
        candidatorList[_indexOfCandidator].upvote++;

        Voted[msg.sender] = true;

        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upvote);
    }

    // end vote
    function endVote() public isOwner{
        require(isLive == true);
        isLive = false;

        emit EndVote(isLive);
    }

}