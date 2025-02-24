// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint256 private storedNumber;

    // Событие, которое вызывается при обновлении числа
    event NumberUpdated(uint256 newNumber);

    // Функция для установки нового числа
    function setNumber(uint256 _number) public {
        storedNumber = _number;
        emit NumberUpdated(_number);
    }

    // Функция для получения сохранённого числа
    function getNumber() public view returns (uint256) {
        return storedNumber;
    }
}
