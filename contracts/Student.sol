// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentManagmentSystem {
    struct Student {
        uint256 ID;
        string name;
        uint256 regNumber;
    }

    address owner;
    uint256 public stdCount = 0;
    mapping(uint256 => Student) public stdRecords;

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addStudent(
        uint256 _ID,
        string memory _Name,
        uint256 _regNumber
    ) public onlyOwner {
        stdCount = stdCount + 1;

        //Fetch the student details with the help of stdCount

        stdRecords[stdCount] = Student(_ID, _Name, _regNumber);
    }

    //update Student

    function editStudent(uint256 _studentIndex, string memory _newName, uint256 _newRegNumber,
    uint256 _newID) public onlyOwner {
        require(_studentIndex >=1 && _studentIndex <= stdCount,"Invalid student index");

        Student storage student = stdRecords[_studentIndex];
        student.name = _newName;
        student.regNumber = _newRegNumber;
        student.ID = _newID;
    }

    //function to delete a student record

    function deleteStudent(uint256 _studentIndex) public onlyOwner{
        require(_studentIndex >= 1 && _studentIndex <= stdCount, "Invalid student index.");

        // Delete the student record and shift the remaining records
        for (uint256 i = _studentIndex; i < stdCount; i++) {
            stdRecords[i] = stdRecords[i + 1];
        }

         // Clear the last record and update the student count
        delete stdRecords[stdCount];
        stdCount--;

    }

    function viewStudent(uint256 _studentIndex) public view returns (string memory, uint256, uint256) {
        require(_studentIndex >= 1 && _studentIndex <= stdCount, "Invalid student index.");
        Student memory student = stdRecords[_studentIndex];
        return (student.name, student.regNumber, student.ID);
    }
}
