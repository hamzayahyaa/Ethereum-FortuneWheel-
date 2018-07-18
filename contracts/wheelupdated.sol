pragma solidity ^0.4.23;
import "./Ownable.sol";
import "./erc721.sol";
import "./SafeMath.sol";
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract Wheel is Ownable,usingOraclize {
using SafeMath for uint;

//uint[8] numbers;
//uint totalBlocks = 8;

uint public randomNumber;
string public random;

event NewOraclizeQuery(string description);
event NewRandom(uint random);

uint256 private minBet = 1; //unit -> wei
uint256 private maxBet = 1500; //unit -> wei
uint256 private pow = 10**16;


/* mappings */
mapping(address => uint256) internal addressToBalance;
mapping(uint => uint) internal rewards;


/* events */
event Transfer(address _from, address _to, uint256 _amount);
//event RandomNumber(uint _randomNumber);
event RewardAmount(uint256 _amount);
event AmountSend(uint _amount);



constructor(){
    //update();
//initializing rewards
uint temp = 12;
    for(uint i=0; i<10; i++){
        rewards[i]=temp;
        rewards[i+10]=temp;

        temp=temp.add(12);
    }
}


/*functions */
function setAddressToBalance(uint256 value) internal {
   //if(addressToBalance[msg.sender] > 0){ //adds up the value if the user has already played
     addressToBalance[msg.sender] = addressToBalance[msg.sender].add(value);
  // }
   //else{ //otherwise simply store the betValue of user against the address
    // addressToBalance[msg.sender]  = value;
   //}

}

function checkAddressToBalance(address player) public view returns (uint256) {
    return addressToBalance[player];
}


function getReward(uint index) public view returns(uint) {
    return rewards[index];
}


function __callback(bytes32 myid, string result) public {
        //if (msg.sender != oraclize_cbAddress()) revert();
        random = result;
        randomNumber = parseInt(result);
        emit NewRandom(randomNumber);
        // do something with the temperature measure..
    }

    function update() public payable {
        emit NewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
        oraclize_query("WolframAlpha", "random number from 0 to 19");
    }


function getRandomNumber() public view returns(uint) {
    return randomNumber;
}

function calculateReward(uint _randomNumber, uint256 betAmount) public view returns(uint256){
    return rewards[_randomNumber].mul(betAmount);
}


//on spin click
uint public a ;
function init() public payable {

   //require(msg.value <= maxBet);
   require(msg.value >= minBet);
  //a=msg.value;
  update();
   setAddressToBalance(msg.value);
   //addressToBalance[msg.sender]  = addressToBalance[msg.sender].add(msg.value);

 //emit spinStart(msg.value);
  //randomNumber generate function
//  generateRandomNumber();

   //emit RandomNumber(randomNumber);
  //calculate the reward function according to mapping
  //transfer

   // a =  (msg.value);
  //a = rewards[randomNumber].mul();
    a = calculateReward(randomNumber, msg.value).mul(pow); //msg.value has wei amount
    emit RewardAmount(a);
  // transferToUser(a);
//prizeAmount
//transferToUser ->

}

function setMinimumBet(uint256 value) public onlyOwner{
  minBet = value;
}

function setMaximumBet(uint256 value) public onlyOwner{
  maxBet = value;
}

function _transfer(address _from, address _to, uint256 _amount) private {
 _to.send(_amount);
 emit Transfer(_from, _to, _amount);
}

function payToContract() public payable{

}

function getContractBalance () public view returns (uint){
    return address(this).balance;
}

function transferToUser(uint256 amount) public returns (string){
  //require(addressToBalance[msg.sender] > 0);
  address to = 0xAAe271C194a03d3FEDEaceb73Ab93aFB83F09c36;
  if( to.send(1000000000000000000))
    return 'true';
    return 'false';
 //emit Transfer(msg.sender, msg.sender, amount);
  //_transfer(owner, msg.sender, amount);
}

}
