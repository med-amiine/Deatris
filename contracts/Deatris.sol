pragma solidity ^0.8.0;
/** 
 * @title Deatris
 * @dev Implements the first version of Deatris we assume the buisness 
 already added and instead of geolocation we are using the countries for the purpose of the hackathon
 */

contract Deatris {

    uint256 public deadline;
    uint nbVisit;
    uint current_date;
    address public user;

     struct User {
        address userAddress;
        uint256 userId;
        string username;
        string country;
    }
    // uint256[] public anArray;
    User[] public users;

    // for test purpos we add the user geolocation
    uint latitude = 4124;
    uint longitude = 210;


    struct Buisness {
        address buisnessAddress;
        uint256 buisnessId;
        string buisnessName;
        string description;
        string country;

        // this will help determine if the user is indeed at the location of the buisness
        // a function to retrive lat and lon offchain will be added
        // uint latitude ;
        // uint longitude;
    }

    Buisness[] public buisnesses; 
    // mapping (address => Buisness) public buisnesses;



    struct Checking{
        uint256 userId;
        uint256 buisnessId;
        bool status;
    }
    Checking[] public check; 


    // only the user can call restricted functions
    modifier restricted() {
        require(msg.sender == user);
        _;
    }

    constructor(){
        nbVisit = 1;
        current_date = block.timestamp ;
        user = msg.sender;
  }
    function setUser(address userAddress, uint256 userId, string memory username, string memory country) public {
        User memory newUser = User({
        userAddress : userAddress,
        userId : userId,
        username : username,
        country : country
        });

        users.push(newUser);
    }

    // count of users
    function getUserCount() public view returns(uint count) {
    return users.length;
}
    // count of buisnesses
    function getBuisnessCount() public view returns(uint count) {
        return buisnesses.length;
}


    function changeCountry(string memory _country) public returns (User memory) {
        for (uint i =0; i<users.length; i++) { 
            users[i].country = _country;         
      }
    }
    

    function setBuisness(address buisnessAddress, uint256 buisnessId, string memory buisnessName, string memory description, string memory country) public {
        
        buisnesses.push(Buisness(buisnessAddress, buisnessId, buisnessName,description, country));

    }

    // count of buisnesses
    function getCheckingCount() public view returns(uint count) {
        return check.length;
}
  // Will return `true` if 10 minutes have passed since `the contract was deployed
//   function tenMinutesHavePassed() public view returns (bool) {
//     return (now >= (deployDate + 10 minutes));
//   }

    function geolocation(uint _latitude, uint _longitude) private view returns (bool){
        if (latitude == _latitude && longitude == _longitude){
            return true;
        }
        else{
            return false;
        }
    }

    function checking(uint userId, uint buisnessId, uint lat, uint lon) public restricted {
        bool res = geolocation(lat,lon);
        if (res == true){
            nbVisit++;
            check.push(Checking(userId, buisnessId, true));

        }
        // else {
        //     status = false;
        // }
        

    }

    // number of visited places
    function getVisitCount() public view returns(uint count) {
        return nbVisit;
        }

    // function collectPoints{}
}

