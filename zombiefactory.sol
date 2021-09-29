pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    event NewZombie(uint zombieId, string name, uint dna);

    struct Zombie {
        string name;
        uint dna;
    }

    // public zombie array - can be read by any contract
    Zombie[] public zombies;
    
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    function createZombie(string memory name, uint dna) internal {
        zombies.push(Zombie(name, dna));
        uint id = zombies.length;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, name, dna);
    }

    function generateRandomDna(string memory str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = generateRandomDna(name);
        createZombie(name, randDna);
    }
}



