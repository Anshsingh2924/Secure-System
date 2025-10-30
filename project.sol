// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SecureSystem
 * @dev A simple smart contract to demonstrate secure access and data management
 */
contract SecureSystem {
    address public owner;
    mapping(address => bool) private authorizedUsers;
    string private secureData;

    event UserAuthorized(address indexed user);
    event UserRevoked(address indexed user);
    event DataUpdated(address indexed byUser, string newData);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedUsers[msg.sender] || msg.sender == owner, "Not authorized");
        _;
    }

    // 🔐 Function 1: Authorize a new user
    function authorizeUser(address _user) public onlyOwner {
        authorizedUsers[_user] = true;
        emit UserAuthorized(_user);
    }

    // 🔐 Function 2: Revoke user access
    function revokeUser(address _user) public onlyOwner {
        authorizedUsers[_user] = false;
        emit UserRevoked(_user);
    }

    // 📝 Function 3: Update secure data
    function updateData(string memory _data) public onlyAuthorized {
        secureData = _data;
        emit DataUpdated(msg.sender, _data);
    }

    // 🔍 Function 4: View secure data
    function viewData() public view onlyAuthorized returns (string memory) {
        return secureData;
    }
}
