// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EightBallPoolGame {
    // Ball colors
    enum BallColor { NONE, SOLID, STRIPED, BLACK }

    // Game state
    struct Game {
        uint id;
        address player1;
        address player2;
        bool isPlayer1Turn;
        bool isGameFinished;
        BallColor[16] rack; // 0: Empty, 1-7: Solid, 8: Black, 9-15: Striped
    }

    mapping(uint => Game) public games;
    uint public gameIdCounter;
    address public gameManager;

    event GameCreated(uint indexed gameId, address player1, address player2);
    event GameEnded(uint indexed gameId, address winner);

    constructor() {
        gameManager = msg.sender;
        gameIdCounter = 1;
    }

    modifier onlyGameManager() {
        require(msg.sender == gameManager, "Only the game manager can call this function");
        _;
    }

    modifier onlyPlayers(uint _gameId) {
        Game storage game = games[_gameId];
        require(msg.sender == game.player1 || msg.sender == game.player2, "You are not a player in this game");
        _;
    }

    function createGame(address _player2) external {
        require(_player2 != address(0) && _player2 != msg.sender, "Invalid player address");
        games[gameIdCounter] = Game(gameIdCounter, msg.sender, _player2, true, false, [BallColor.NONE, BallColor.SOLID, BallColor.SOLID, BallColor.SOLID, BallColor.SOLID, BallColor.SOLID, BallColor.SOLID, BallColor.SOLID, BallColor.NONE, BallColor.STRIPED, BallColor.STRIPED, BallColor.STRIPED, BallColor.STRIPED, BallColor.STRIPED, BallColor.STRIPED, BallColor.BLACK]);
        emit GameCreated(gameIdCounter, msg.sender, _player2);
        gameIdCounter++;
    }

    function endGame(uint _gameId, address _winner) internal {
        Game storage game = games[_gameId];
        require(!game.isGameFinished, "Game already finished");
        game.isGameFinished = true;
        emit GameEnded(_gameId, _winner);
    }

    function switchTurn(uint _gameId) internal {
        Game storage game = games[_gameId];
        require(!game.isGameFinished, "Game already finished");
        game.isPlayer1Turn = !game.isPlayer1Turn;
    }
function pocketBall(uint _gameId, uint _ballNumber) external onlyPlayers(_gameId) {
    Game storage game = games[_gameId];
    require(!game.isGameFinished, "Game already finished");
    require((game.isPlayer1Turn && msg.sender == game.player1) || (!game.isPlayer1Turn && msg.sender == game.player2), "Not your turn");
    require(isValidPocket(game.rack, _ballNumber), "Invalid pocket");

    game.rack[_ballNumber] = BallColor.NONE;

    // Check if all balls of a color are pocketed
    bool allSolidPocketed = true;
    bool allStripedPocketed = true;
    for (uint i = 1; i <= 15; i++) {
        if (game.rack[i] == BallColor.SOLID) {
            allSolidPocketed = false;
        } else if (game.rack[i] == BallColor.STRIPED) {
            allStripedPocketed = false;
        }
    }

    if (allSolidPocketed || allStripedPocketed) {
        endGame(_gameId, msg.sender);
    } else {
        switchTurn(_gameId);
    }
}

    function isValidPocket(BallColor[16] memory _rack, uint _ballNumber) internal pure returns (bool) {
        return _rack[_ballNumber] != BallColor.NONE;
    }
}

// Contract Deployed at sepolia Scroll Testnet : 0x74586B4482e94EC89a030cf171886b61aB2cd665

