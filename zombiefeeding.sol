pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

interface  KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {
    // CryptoKittens Address
    address ckAddress = address(0x06012C8CF97BEAD5DEAE237070F9587F8E7A266D);

    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint zombieId, uint targetDna, string memory species) public {
        require(msg.sender == zombieToOwner[zombieId]); 

        Zombie storage myZombie = zombies[zombieId];
        uint newDna = (myZombie.dna + (targetDna % dnaModulus)) / 2;

        if(keccak256(species) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        createZombie("NoName", newDna);
    }

    function feedOnKitty(uint zombieId, uint kittyId) public {
        uint kittyDna;
        (,,,,,,,,, kittyDna) = kittyContract.getKitty(kittyId);
        feedAndMultiply(zombieId, kittyDna, "kitty");
    }
}


