pragma solidity 0.5.1;

contract Casino {

    uint256 public minimum_bet=1;
    uint256 public total_ether=0;
    uint256 public total_bets=0;
    player_details[] public players;
    uint256 public player_count = 0;
    uint256 public constant max_bets=100;

    //Structure to store all details of players
    struct player_details {
        string player_name;
        address payable wallet;
        uint256 bet_amount;
        uint256 bet_number;
    }

    //Function to send ether to the winners if they have guessed the corrrect number 
    function send_ether(uint256 winning_no) public payable{
        for(uint256 i = 0; i<players.length; i++){
            if(players[i].bet_number==winning_no){
                players[i].wallet.transfer(10);
            }
        }
    }


    //Function to add players to the bet, They can choose a bet amount and also betting number
    function add_player(string memory name,address payable wallet,uint256 bet_amount, uint256 bet_number) public {
        require(bet_amount >= minimum_bet);
        players.push(player_details(name,wallet,bet_amount,bet_number));
        player_count++;
        total_bets++;
        total_ether+=bet_amount;
    }


    //Function to generate a random number between 1 and 10(This isnt secure though)and call the function send_ether
    //to send ether to the winners
    function generate_random_number() public {
      uint256 random_number = block.number % 10 + 1; // This isn't secure
      send_ether(random_number);
    }


    //For making the contract accept ether payment from outside
    function() external payable {}
}
