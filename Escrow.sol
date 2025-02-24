// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEscrow {
    address public arbiter;
    address public beneficiary;
    bool public isApproved;

    event Deposited(address indexed sender, uint256 amount);
    event Approved(address indexed arbiter);

    constructor(address _arbiter, address _beneficiary) payable {
        require(msg.value > 0, "Deposit must be non-zero");
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        emit Deposited(msg.sender, msg.value);
    }

    function approve() external {
        require(msg.sender == arbiter, "Only arbiter can approve");
        require(!isApproved, "Already approved");
        isApproved = true;
        (bool success, ) = beneficiary.call{value: address(this).balance}("");
        require(success, "Transfer failed");
        emit Approved(msg.sender);
    }
}
