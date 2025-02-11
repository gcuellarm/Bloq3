# 🚀 Real Crypto

The aim of this project is to create a real and personal crypto token and explore some of the possibilities that it has. To accomplish that, we will make good use of the openzeppelin ERC20 libraries.
## 📍 Imports
These are the 3 imports used for this contract:

- ```import "@openzeppelin/contracts/token/ERC20/ERC20.sol";```
- ```import "@openzeppelin/contracts/access/AccessControl.sol";```
- ```import "@openzeppelin/contracts/security/Pausable.sol";```

## 📃 Contract Details
### 🛠️ Constructor
Let us begin with the constructor. We will set 4 roles, 3 of which must be given as parameters to the constructor. We must not forget the ERC20 import, we must send as parameters the name and symbol of our new crypto. It should look like this:  
``` constructor(address minter_, address burner_, address pauser_) ERC20("MyToken", "TKN") {} ```

All these roles are set up in the constructor, using the *_grantRole* function. We'll need a role for the **admin position**, **minter position**, **burner position**, **pauser position** and **snapshot position**. The result should be like this:  
```_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);```  
```_grantRole(MINTER_ROLE, minter_); ```  
```_grantRole(BURNER_ROLE, burner_); ```  
```_grantRole(PAUSER_ROLE, pauser_);```  

Some errors may appear, but it' nothing to worry about. To solve it we have to create the constant for these roles (except for the admin role) out of the constructor. We'll get something like this:  
```bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");```  
```bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");```  
```bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");```  

All those roles need to be created first to be granted as we can see in the constructor. The admin role needs no more and no less than the *"msg.sender"*, which is the creator in this case (the admin is the creator).

### ⚙️ Functions
All the roles we have created in the previous step must fit in the functions needed now for certain acions.
- **Mint** *function*: with this function we force the "mint" (add more tokens to a certain account) action to be done only by the minter role (and admin).
``` solidity
function mint(address to_ , uint amount_) public  onlyRole(MINTER_ROLE){
        require(hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not a minter");
        _mint(to_, amount_);
}
```
- **Burn** *function*: with this function we force the "burn" action (burn or "delete" some tokens) to be done only by the burner role:
``` solidity
function burn(uint amount_) public onlyRole(BURNER_ROLE) {
    _burn(msg.sender, amount_);
}
```
- **Pause** and **Unapuse** *functions*: with these functions we force the "pause" and "unpause" actions (pause or resume the activity of the tokens) to be done only by the pauser role:
``` solidity
function pause() public onlyRole(PAUSER_ROLE){
    _pause();
}

function unpause() public onlyRole(PAUSER_ROLE){
    _unpause();
}
```
- **Balance** *function*: this function is used to check the balance of the account:
```solidity
function balance(address account_) public view onlyRole(DEFAULT_ADMIN_ROLE) returns(uint256){
        return balanceOf(account_);
}
```
- **ApproveAmount** *function*: with this function we can set the amount available for an account to transfer to another account or whatever action needed:
```solidity
function approveAmount(address to_, uint amount_) public onlyRole(DEFAULT_ADMIN_ROLE) returns(bool){
        return approve(to_, amount_);
}
```

## Extra functions

- There's a function that is not in the contract that may be useful and similar to the role of admin. If we wanted to specify that a function/role can only be executed by the owner we can use *onlyOwner* this way:
```solidity
function mint(address account_, uint amount_) public onlyOwner {
    _mint(account_, 1000 * 1e18);
}
```
In this case we force the **"mint"** *function* only to be executed by the owner. 
But first we would need to import: ```import "@openzeppelin/contracts/access/Ownable.sol";``` and say our contract is **"Ownable"**: ```contract MyContract is Ownable {}```

- In the contract, we already have the **burn** *function*. In this case, the function allows *"msg.sender"* to burn its own tokens. But if we wanted to allow someone with the "BURNER_ROLE" to burn tokens from any account, we should have imported ***ERC20Burnable.sol*** and use a function like this:
```solidity
function burnFrom(address account_, uint256 amount_) public onlyRole(BURNER_ROLE) {
    _burn(account_, amount_);
}
```
## 📚 Documentation

[Documentation](https://docs.openzeppelin.com/contracts/3.x/access-control)

## Tech Stack

**Client:** Solidity

**IDE:** Visual Studio Code, Remix IDE


## Authors

- [@gcuellarm](https://www.github.com/gcuellarm)
