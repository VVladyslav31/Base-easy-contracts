// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDAO {
    struct Proposal {
        string description;
        uint256 voteCount;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public members;
    mapping(uint256 => mapping(address => bool)) public voted;

    event ProposalCreated(uint256 proposalId, string description);
    event Voted(uint256 proposalId, address voter);
    event ProposalExecuted(uint256 proposalId);

    constructor() {
        // Создатель контракта становится первым членом DAO
        members[msg.sender] = true;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Not a DAO member");
        _;
    }

    function addMember(address newMember) public onlyMember {
        members[newMember] = true;
    }

    function createProposal(string memory description) public onlyMember {
        proposals.push(Proposal({
            description: description,
            voteCount: 0,
            executed: false
        }));
        emit ProposalCreated(proposals.length - 1, description);
    }

    function vote(uint256 proposalId) public onlyMember {
        require(proposalId < proposals.length, "Invalid proposal");
        require(!voted[proposalId][msg.sender], "Already voted");
        voted[proposalId][msg.sender] = true;
        proposals[proposalId].voteCount++;
        emit Voted(proposalId, msg.sender);
    }

    function executeProposal(uint256 proposalId) public onlyMember {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Already executed");
        // Для простоты: предложение выполняется, если получено хотя бы 1 голос
        require(proposal.voteCount >= 1, "Not enough votes");
        proposal.executed = true;
        emit ProposalExecuted(proposalId);
    }
}
