// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Function contract 
////////////////// Start ///////////////

 contract funcBehaviour {
 
    uint age = 30;
   
    function getAge() public view returns (uint){
        return age;
    }
    
    function GetNumber() public pure returns (uint){
         uint Number =  150;
         return Number;
    }

    uint public recieveamount; //1

    function GetAmount() public payable
    {
     recieveamount = recieveamount + msg.value; //1
    }
}

///////////////// END /////////////////////




// Inheritance contract 
////////////   start //////////////////

contract Student {

     uint public age;
     string public name;

      function setAge(uint _age) public {
      age = _age;
      }

      function setName(string memory _name) public {
      name = _name;
      }

 }

contract Teacher is Student {
    
    string public setDesigna;
    
     function setDesignation(string memory _set) public {
       setDesigna = _set;
     }
 }
 
////////////// END ////////////////////////



// Modifier Contract 
////////////////// Start//////////////////// 
contract modifierExample {

        address public owner;
        uint public sum;

        constructor() {
            owner = msg.sender;
        }       
        modifier OnlyOwner(){
          
            require(msg.sender == owner , "You are not the Owner");
            _;
        }

        function add() public OnlyOwner returns (uint)
         {
             sum = sum + 1;   
             return sum;            
        }
}

/////////////////// END //////////////////////



// Array Contract 
////////////// Start ////////////////////

contract Array{

    uint[] public dynamicArray;         // dynamic
    uint[] public myArray2 = [1,2,3];   
    uint[10] public myFixedArray;   //fixed


   function push(uint _value) public {
     dynamicArray.push(_value);
   }

  function pop() public {
    dynamicArray.pop();
  }

  function getLength() public view returns (uint) {
    return dynamicArray.length;
  }
  function remove(uint _index) public {
   delete dynamicArray[_index];
   pop();
  } 
}
/////////////// END ////////////////////




// Struct Contract 
//////////////// Start /////////////////

contract stuctsExample {

  struct Teachers {
    string name;
    uint age;
  }
    
   struct Students {
     string name;
     uint age;
     uint rollnumber;
     bool isPass; 
   }

    Teachers[]  public teacher;
    Students[] public student;
     
     
     function createTeacherRecord(string memory _name, uint _age) public {
       teacher.push(Teachers(_name,_age));
     }

     function createStudentRecord(string memory name, uint age , uint rollnumber, bool isPass) public {
         student.push(Students(name , age , rollnumber, isPass));
     }
 

    function getStudentRecord(uint _index) public view returns(string memory, uint , uint , bool){
        Students storage studentObj = student[_index];
        return (studentObj.name,studentObj.age,studentObj.rollnumber,studentObj.isPass);
    } 

}

/////////////// END /////////////////////



// Mapping contract 
/////////////// Start //////////////////

contract mappingExample {

   mapping(uint => address) public myAddress;

   function add(uint id, address _addr) public {
       myAddress[id] = _addr;    
   }
}

//////////////// End /////////////////



// Enum Contract 
/////////////// Start /////////////

contract enumExample {

       enum Status {         
            Pending, 
            Approved,
            Reject      
       }

       Status public status;
       string public statusCheck; 

       function Approved() public {
           require(status == Status.Pending);
           status = Status.Approved;
           statusCheck =  "Approved";

       }
       function Reject() public {
           require(status == Status.Approved);
           status = Status.Reject;
           statusCheck =  "Reject";
       }

}

///////////////// END ///////////////////




// Sending and reciving ETH Contract
////////////////// Start ///////////////////

// 1 transfer
// 2 send
// 3 call

contract ReceiveEther
{
   fallback() external payable {
       // custom function code
    }

    receive() external payable {
        // custom function code
    }

   function getBalance() public view returns (uint) {

       return address(this).balance;
   }

}
contract sendEther {
 
        bytes public data;
       function sendTransfer(address payable _to) public payable {
           _to.transfer(msg.value);
       }

       function sendEtherViaSend(address payable _to) public payable{
           bool sent = _to.send(msg.value);
           require(sent , "Failed to send Ether");
       }

       function sentViaCall(address payable _to) public payable {
          (bool sent , bytes memory _data) =  _to.call{value:msg.value,gas:2000}("");
           data = _data;
           require(sent , "Failed to send Ether");
           
       }

}


///////////////////// END //////////////////////////




// Wallet development Contract (Using event)
///////////// Start //////////////////

contract walletDevelopment {
 
        event Deposit(address depositAddress , uint amount , uint balance);
        event Withdraw(uint amount , uint balance);
        event Transfer(address to , uint amount , uint balance);


        address payable public owner;

        constructor() public payable {
            owner = payable(msg.sender);
        }

       function deposit(uint _amount) public payable{
           require(msg.value > 0 , "Please sent ether");
           emit Deposit(msg.sender , _amount , address(this).balance);
       }

        modifier onlyOwner() {
            require(msg.sender == owner , "Your are not the onwer");
         _;
        }

       function withdraw(uint _amount) public onlyOwner {
           owner.transfer(_amount);
           emit Withdraw(_amount , address(this).balance);

       }

       function transfer(address payable _to , uint _amount) public onlyOwner {
           
           _to.transfer(_amount);
           emit Transfer(_to , _amount ,  address(this).balance);
        }


       function getBalance() public view returns(uint){
           return address(this).balance;
       }
}


///////////////////// END ///////////////////





// Hash Function 
/////////////////// START ///////////////////

 contract HashFunction {
 
     function hash(string memory _text , uint _num , address _addr)
     public pure returns(bytes32)
     {

         return keccak256(abi.encodePacked(_text , _num , _addr));

     }
     
//0xe5d11b08737f5dbf924278d835533b2b1e65c2fe1b5b119c5fdd21555547b9c4
//0x1edf4aae368e845d5d1cd28aec0624c467d538ecc7e5660765ed2afedca37aca
//0x40120e57c637c5d216032d19c65bc64e072b32cfe0a6b4f0e6c65ddbaf251fff
     function collision(string memory _text , string memory _secText)
     public pure returns(bytes32)
     {
                                         // AA = BBB  == AABBB           
         return keccak256(abi.encode(_text , _secText));
     }
 }

contract GuessTheMagicWorld{
 //0x541111248b45b7a8dc3f5579f630e74cb01456ea6ac067d3f4d793245a255155

    function hash(string memory _text)
     public pure returns(bytes32)
     {
         return keccak256(abi.encodePacked(_text));

     }

    bytes32 public answer = 0x541111248b45b7a8dc3f5579f630e74cb01456ea6ac067d3f4d793245a255155;

     function guess(string memory _word) public view returns (bool) {
         return keccak256(abi.encodePacked(_word)) == answer;
     }
}


////////////////////// END /////////////////////////////




// Call Other contract function 
///////////////////////////// START /////////////////////////

contract Callme {
    uint public x;
    uint public value;
    uint public addv1;
    

    function setX(uint _x) public returns(uint) {
        x = _x;
        return x;
    }

    function add(uint _a, uint _b) public returns(uint) {
        addv1 = _a + _b;
        return addv1;
    }

     function setXandSendEther(uint _x) public payable returns (uint , uint) {

        x = _x;
        value = msg.value;
        
        return (x , value);
    }
//0xd2a5bC10698FD955D1Fe6cb468a17809A08fd005
}

contract Caller {

     function setValueOFContractCallme(Callme _call , uint _x) public {
         
         uint x = _call.setX(_x);
         uint x1 = _call.add(_x , 1);
     }
     function addValueOfContractCallme(Callme _call , uint _x, uint _y) public {
                     //   add (1 , 2)         
     }
     function setXandSendEther(Callme _call , uint _x) public payable {

     }


}


////////////////////// END //////////////////////////////////



// Player State Contract ///
//////////////////// START ///////////////////////

import "@openzeppelin/contracts/access/Ownable.sol";

contract playerState is Ownable{
    
 
   struct Player {
       string hash;
       address playerAddress;
       uint score;
   }

   uint public playerCount;
   mapping(uint => Player) public playerMapping;
   mapping(address => bool) public whitelistedAddresses;

   event AddingNewPlayer (
       uint playerId,
       address playerAddress
   );

    modifier isWhitelisted() {
        require(whitelistedAddresses[msg.sender], "Unauthorized Address");
        _;
    }

   function addWhitelistedAddress(address addWhitelistedAddress) external onlyOwner {
       whitelistedAddresses[addWhitelistedAddress] = true;
   }
   
   function removeWhitelistedAddress(address addWhitelistedAddress) external onlyOwner{
       whitelistedAddresses[addWhitelistedAddress] = false;
   }


   function createNewPlayer(
       string memory _hash,
       address _playerAddress,
       uint _score
   ) external 
     isWhitelisted
   {

       playerCount++;
       playerMapping[playerCount] = Player(_hash, _playerAddress, _score);
       emit AddingNewPlayer(playerCount,_playerAddress);

   }


   function UpdatingPlayer(
       uint playerId,
       string memory _hash,
       address _playerAddress,
       uint _score
   )
   external
   {
       playerMapping[playerId].hash = _hash;
       playerMapping[playerId].playerAddress = _playerAddress;
       playerMapping[playerId].score = _score;
       
   }

}
