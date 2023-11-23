// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

// The beginning of our smart contract where it have the structure of the game candidates as id, name and vote count
contract GameElection {
    struct Game {
        uint id;
        string name;
        uint voteCount;
    }
    // mapping the public variable called "games" and keep the number of total of the games as "games count". 
    mapping(uint => Game) public games;
    uint public gamesCount;

    // Mapping to check the address that has been voting
    mapping(uint => bool) public voters;

    // Function that implement the smart contract, and declare the games candidates for this voting system
    function Elections () public {
        addGame("Assassin's Creed Mirage");
        addGame("Final Fantasy XVI");
        addGame("Hogwarts Legacy");
        addGame("Resident Evil 4");
        addGame("Spider-Man 2");
        addGame("Super Mario Bros. Wonder");
        addGame("The Legend of Zelda: Tears of the Kingdom");
    }

    //Private function that adding a new game for the mapping games
    function addGame (string memory _name) private {
        gamesCount ++; //implementation of the couting of the games
        games[gamesCount] = Game(gamesCount, _name, 0); //Getting games information and mapping them
    }
    // Function to allow people to vote and garante that is a valid ID
    function vote (uint _voterId, uint _gameId) public returns (bool) {
        if (voters[_voterId]) {
            return false; // The voter has already voted, so we return false
        }
        require(_gameId > 0 && _gameId <= gamesCount);

        games[_gameId].voteCount++;
        voters[_voterId] = true;
        return true; // The vote was successful, so we return true
    }

    //Function to return the results of the game with more votes or the winnig game
    function getResults() public view returns (string memory, uint) {
        uint maxVoteCount = 0;
        uint winningGameId = 0;
        for (uint i = 1; i <= gamesCount; i++) {
            if (games[i].voteCount > maxVoteCount) {
                maxVoteCount = games[i].voteCount;
                winningGameId = i;
            }
        }
        return (games[winningGameId].name, maxVoteCount);
    }

}