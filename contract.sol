// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ScholarshipCreditContract {

    address private owner;
    uint totalCredits = 1000000;
    mapping(address => uint) scholarship;
    mapping(address => bool) students;
    mapping(address => bool) merchants;
    mapping(address => uint) merchantsAccount;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner has access to this");
        _;
    }

    modifier onlyStudents {
        require(students[msg.sender], "Only students have access");
        _;
    }

    modifier approved {
        require(msg.sender == owner || students[msg.sender] == true || merchants[msg.sender] == true, "Access denied");
        _;
    }

    //This function assigns credits to student getting the scholarship
    function grantScholarship(address studentAddress, uint credits) public onlyOwner {
        require(studentAddress != owner, "Owner cannot accept this scholarship");
        require(!merchants[studentAddress], "Merchant cannot accept this scholarship");
        scholarship[studentAddress] += credits;
        totalCredits -= credits;
        students[studentAddress] = true;
    }

    //This function is used to register a new merchant who can receive credits from students
    function registerMerchantAddress(address merchantAddress) public onlyOwner {
        require(merchantAddress != owner, "Owner cannot be the merchant");
        require(!students[merchantAddress], "Student cannot be the merchant");
        merchants[merchantAddress] = true;
    }

    //This function is used to deregister an existing merchant
    function deregisterMerchantAddress(address merchantAddress) public onlyOwner {
        require(merchants[merchantAddress] == true, "This is not an existing merchant");
        // require(merchantsAccount[merchantAddress] == 0, "Credits yet to be cashed");
        merchants[merchantAddress] = false;
        totalCredits += merchantsAccount[merchantAddress];
        merchantsAccount[merchantAddress] = 0;
    }

    //This function is used to revoke the scholarship of a student
    function revokeScholarship(address studentAddress) public onlyOwner {
        require(students[studentAddress], "This is not an existing student");
        students[studentAddress] = false;
        totalCredits += scholarship[studentAddress];
        scholarship[studentAddress] = 0;
    }

    //Students can use this function to transfer credits only to registered merchants
    function spend(address merchantAddress, uint amount) public onlyStudents {
        require(scholarship[msg.sender] >= amount, "Invalid Amount");
        require(merchants[merchantAddress], "Invalid Merchant");
        merchantsAccount[merchantAddress] += amount;
        scholarship[msg.sender] -= amount;
    }

    //This function is used to see the available credits assigned.
    function checkBalance() public view approved returns (uint) {
        
        if (merchants[msg.sender] == true) {
            return merchantsAccount[msg.sender];
        }
        if (students[msg.sender] == true) {
            return scholarship[msg.sender];
        }

        return totalCredits;
    }
}
