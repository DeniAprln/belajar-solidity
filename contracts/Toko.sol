// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract warung {
    address public pemilik;

    constructor() {
        pemilik = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == pemilik, "Anda bukan Owner!");
        _;
    }

    event tambahBeli(address indexed pemilik, uint256 jumlah);
    mapping(address => uint256) public saldo;

    function Beli(uint256 _jumlah) public {
        saldo[msg.sender] += _jumlah;
        emit tambahBeli(msg.sender, _jumlah);
    }

    function cekSaldo(address _alamat) public view returns (uint256) {
        return saldo[_alamat];
    }
}