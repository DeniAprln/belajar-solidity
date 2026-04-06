// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract simpleVault {
    address public pemilik;
    
    error bukanPemilik(address pengirim, address pemilik);
    error saldoKosong(address pengirim);

    constructor() {
        pemilik = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != pemilik){
            revert bukanPemilik(msg.sender, pemilik);
        }
        _;
    }

    event SaldoDisimpan(address indexed pemilik, uint256 jumlah);
    event SaldoDitarik(address indexed pemilik, uint256 jumlah);
    mapping(address => uint256) public saldo;

    function simpan() public payable {
        saldo[msg.sender] += msg.value;
        emit SaldoDisimpan(msg.sender, msg.value);
    }

    function tarik() public onlyOwner {
        uint256 jumlah = saldo[msg.sender];
        if (jumlah == 0) {
            revert saldoKosong(msg.sender);
        } 

        // effect dlu
        saldo[msg.sender] = 0;

        // lalu interactions
        (bool berhasil, ) = msg.sender.call{value: jumlah} ("");
        if (!berhasil) {
            revert("Transaksi gagal!");
        }
        emit SaldoDitarik(msg.sender, jumlah);

    }
    // update
}