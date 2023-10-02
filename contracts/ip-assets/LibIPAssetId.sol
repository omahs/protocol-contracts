// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import { IPAsset } from "contracts/IPAsset.sol";

library LibIPAssetId {
    error InvalidIPAsset(IPAsset ipAsset);

    uint256 private constant _ID_RANGE = 10 ** 12;

    function _zeroId(IPAsset ipAsset) internal pure returns (uint256) {
        if (ipAsset == IPAsset.UNDEFINED) revert InvalidIPAsset(ipAsset);
        return _ID_RANGE * (uint256(ipAsset) - 1);
    }

    function _lastId(IPAsset ipAsset) internal pure returns (uint256) {
        if (ipAsset == IPAsset.UNDEFINED) revert InvalidIPAsset(ipAsset);
        return (_ID_RANGE * uint256(ipAsset)) - 1;
    }

    function _ipAssetTypeFor(uint256 id) internal pure returns (IPAsset) {
        // End of _ID_RANGE is zero (undefined) for each IPAsset
        // Also, we don't support ids higher than the last IPAsset enum item
        if (id % _ID_RANGE == 0 || id > _ID_RANGE * (uint256(IPAsset.ITEM)))
            return IPAsset.UNDEFINED;
        return IPAsset((id / _ID_RANGE) + 1);
    }
}
