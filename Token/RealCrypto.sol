//SPDX-License-Identifier: LGPL-3.0-only

//Version
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";


contract RealCrypto is ERC20, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");


/*    constructor(address minter) public ERC20("MyToken", "TKN");
        _setupRole(MINTER_ROLE, minter); //Grant the minter role to a specified account

    }*/
    constructor(address minter_, address burner_, address pauser_) ERC20("MyToken", "TKN") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // The creator is the admin
        _grantRole(MINTER_ROLE, minter_); //Grant the minter role to a specified account
        _grantRole(BURNER_ROLE, burner_); //Grant the burner role to a specified account
        _grantRole(PAUSER_ROLE, pauser_); //Grant the pauser (and unpause) role to a specified account, only to the owner
    }

   

    function mint(address to_ , uint amount_) public  onlyRole(MINTER_ROLE){
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(to_, amount_);
    }

    function burn(address to_ , uint amount_) public onlyRole(BURNER_ROLE) {
        _burn(to_, amount_);
    }

    function pause() public onlyRole(PAUSER_ROLE){
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE){
        _unpause();
    }

    function balance(address account_) public view onlyRole(DEFAULT_ADMIN_ROLE){
        account_ = msg.sender;
        IERC20(msg.sender).balanceOf(address(this));
    }



   
    


}
