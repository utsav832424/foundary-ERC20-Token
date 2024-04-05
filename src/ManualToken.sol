// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

contract ManualToken {
    mapping(address => uint256) private s_balance;

    function name() public pure returns (string memory) {
        return "ManualToken";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balance[_owner];
    }

    function transfer(address _to, uint256 _value) public {
        uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balance[msg.sender] -= _value;
        s_balance[_to] += _value;
        assert(balanceOf(msg.sender) + balanceOf(_to) == previousBalance);
    }
}
