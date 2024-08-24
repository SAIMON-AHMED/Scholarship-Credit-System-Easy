# Scholarship-Credit-System-Easy

Pied Piper is an organization that provides scholarships to students for their educational needs. In the past, they transferred the entire scholarship amount directly to the winning students to use for their educational expenses. However, they realized that some students were misspending the money. To solve this problem, Pied Piper has decided to introduce a credit system using smart contracts and blockchain technology. Instead of sending money directly to the students, Pied Piper will assign an equivalent amount of credits to the students. These credits can only be transferred to merchants approved by Pied Piper.

For this project, Pied Piper has hired you to create the smart contract. The following requirements have been specified:


The total number of credits is 1,000,000, initially held by the contract owner, Gavin.
All addresses for owner, students, and merchants must be unique.
A student is allowed to receive multiple scholarships.
Merchants can only receive credits and can cash them in through Pied Piper. They can also deregister their address from the list of merchant addresses.
The smart contract must be accessible to students and merchants for transferring and receiving credits.

The smart contract must contain the following public functions:

 

Input:
grantScholarship(address studentAddress, uint credits): This function is only accessible to the owner of the contract. The owner can use this function to assign credits to the wallet address of a student.

registerMerchantAddress(address merchantAddress): This function is only accessible to the owner of the contract. The owner can use this function to register a new merchant who can receive credits from students.

deregisterMerchantAddress(address merchantAddress): This function is only accessible to the owner of the contract. The owner can use this function to deregister an existing merchant. This will be done when the merchant has been credited an equivalent amount of cash money, which is out of scope for implementation of the smart contract. After deregistration, the student won't be able to send credits to this merchant until they are registered again.

revokeScholarship(address studentAddress):This function is only accessible to the owner of the contract. The owner can use this function to revoke the scholarship of a student. After revocation, any unspent credits assigned to the student will be assigned back to Pied Piper, and the student won't have access to spending any credits.

spend(address merchantAddress, uint amount):This function is only accessible to students holding scholarships. Students can use this function to transfer credits only to registered merchants.

 

Output:
checkBalance() returns (uint) This function is accessible by scholarship holding students, registered merchants, and the owner. Using this function, they can see the available credits assigned to their address.
