pragma solidity 0.5.1;

contract Casino {

    uint256 public minimum_bet=1;
    uint256 public total_ether=0;
    uint256 public total_bets=0;
    player_details[] public players;
    uint256 public player_count = 0;
    uint256 public constant max_bets=100;

    struct player_details {
        string player_name;
        address payable wallet;
        uint256 bet_amount;
        uint256 bet_number;
    }

    function send_ether(uint256 winning_no) public{
        for(uint256 i = 0; i<players.length; i++){
            if(players[i].bet_number==winning_no){
                players[i].wallet.transfer(total_ether/player_count);
            }
        }
    }

    function add_player(string memory name,address payable wallet,uint256 bet_amount, uint256 bet_number) public {
        require(bet_amount >= minimum_bet);
        players.push(player_details(name,wallet,bet_amount,bet_number));
        player_count++;
        total_bets++;
        total_ether+=bet_amount;
    }
    // Person[] public people;

    // uint256 public peopleCount;

    // struct Person {
    //     string _firstName;
    //     string _lastName;
    // }

    // function addPerson(string memory _firstName, string memory _lastName) public {
    //     people.push(Person(_firstName, _lastName));
    //     peopleCount += 1;
    // }
}