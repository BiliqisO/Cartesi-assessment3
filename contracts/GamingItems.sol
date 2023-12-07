// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract GamingToken is ERC1155 {
    uint256 public constant Avatar = 1;
    uint256 public constant Gold = 2;
    uint256 public constant Silver = 3;

    constructor(address[] memory _players) ERC1155("") {
        uint256[3] memory cItems = [Avatar, Gold, Silver];
        uint32[3] memory cValues = [1, 10 ** 6, 10 ** 9];
        uint256[] memory items = new uint256[](3);
        uint256[] memory values = new uint256[](3);

        for (uint256 i; i < 3; ++i) {
            items[i] = cItems[i];
            values[i] = uint256(cValues[i]);
        }

        for (uint256 i; i < _players.length; ++i) {
            address _player = _players[i];
            require(balanceOf(_player, Avatar) == 0, "Duplicate Player");
            _mintBatch(_player, items, values, "");
        }
    }

    // override transfers for SoulBound token
    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        virtual
        override
    {
        for (uint256 i; i < ids.length; ++i) {
            uint256 id = ids[i];

            // Allow minting only
            if (from != address(0)) {
                if (id == Avatar) {
                    revert("Avatar is SoulBound");
                }

                if (balanceOf(to, Avatar) == 0) {
                    revert("Only Avatar Owners can transfer");
                }
                if (balanceOf(from, Avatar) == 0) {
                    revert("Only Avatar Owners can transfer");
                }
            }
        }

        super._update(from, to, ids, values);
    }
}
