pragma solidity ^0.5.0;

import "./ownership/Ownable.sol";

/// @title IronCoin Contract
/// @dev This contract's goal is to provide a simple, working implementation of
///  ERC-20 token in order to be used with a Ruby frontend!
contract IronCoin is Ownable {
  /// @dev Stores the balance for every account.
  mapping (address => uint) balances;

  // Define events Transfer and Approval here!
  event Transfer (
    address indexed _from,
    address indexed _to,
    uint _value
  );

  event Approval (
    address indexed _owner,
    address indexed _spender,
    uint _value
  );

  string public version; // Version of the contract, following Semver.
  string public name = "EPSI";
  string public symbol = "EPI";
  uint8  public decimals = 5;

  constructor(string memory _version) Ownable() public {
    // Do Something here!
    version = _version;
    balances[msg.sender] = 1000000000;
  }

  /// @dev Returns the total supply of existing token.
  function totalSupply() public pure returns (uint) {
    // Do Something here!
    return 1000000000;
  }

  /// @dev Returns the balance of tokens of someone.
  /// @param _owner The person you want to check balance.
  function balanceOf(address _owner) public view returns (uint) {
    // Do Something here!
    return balances[_owner];
  }

  /// @dev Transfer some token to someone else.
  /// @param _to The receiver of transfer.
  /// @param _value The amount to transfer.
  /// @return True if transfer is successfull, False otherwise.
  function transfer(address _to, uint _value) public returns (bool success) {
    // Do Something here!
    address _from = msg.sender;
    require(balances[msg.sender] >= _value);
    emit Transfer(_from, _to, _value);
    balances[_from] -= _value;
    balances[_to] += _value;
    return true;
  }

  mapping (address => mapping (address => uint)) allowances;

  /// @dev Approve a third party to withdraw a certain amount of tokens for the owner.
  /// @param _spender The future approved spender.
  /// @param _value The maximum value the spender will be able to withdraw.
  /// @return True if approving successfull, False otherwise.
  function approve(
    address _spender,
    uint _value
  ) public returns (bool success) {
    // Do Something here!
    address myself = msg.sender;
    allowances[myself][_spender] = _value;
    // allowances[msg.sender][_spender] = _value;
    emit Approval(myself, _spender, _value);
    return true;
  }

  /// @dev Transfer some tokens form one account to the other if previously approved.
  /// @param _from The account to send from.
  /// @param _to The account to send to.
  /// @param _value The amount to send.
  /// @return True if transfer successfull, False otherwise.
  function transferFrom(
    address _from,
    address _to,
    uint _value
  ) public returns (bool success) {
    // Do Something here!
    bool allowed = allowances[_from][msg.sender] >= _value;
    bool enoughMoney = balances[_from] >= _value;
    require(enoughMoney && allowed);
    emit Transfer(_from, _to, _value);
    balances[_from] -= _value;
    balances[_to] += _value;
    allowances[_from][msg.sender] -= _value;
    return true;
  }

  /// @dev Returns the amount a spender can withdraw for another account.
  /// @param _owner The account to spend from.
  /// @param _spender The account allowed to spend.
  /// @return The total amount remaining to spend for spender.
  function allowance(
    address _owner,
    address _spender
  ) public view returns (uint remaining) {
    // Do something here!
    return allowances[_owner][_spender];
  }
}
