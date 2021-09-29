pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint zombieId, uint targetDna) public {
        require(msg.sender == zombieToOwner[zombieId]); 
        Zombie storage myZombie = zombies[zombieId];
        uint newDna = (myZombie.dna + (targetDna % dnaModulus)) / 2;
        createZombie("NoName", newDna);
    }
}


