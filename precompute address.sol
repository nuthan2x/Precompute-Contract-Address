//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.16;

contract maxx{
    address public owner;
    constructor(address _owner){
        owner = _owner;

    }
    function add(uint x,uint y) public pure returns(uint){
        return x + y;
    }
}

contract deploy_maxx_withcreadte2{
    event Deploy_maxx(address deployedcontract);

    function deploy_maxx(uint _salt) public {
        maxx _contract = new maxx{salt : bytes32(_salt)}(msg.sender);

        emit Deploy_maxx(address(_contract));
    }

    function get_CONTRACT_address(bytes memory _bytecode,uint _salt ) external view returns(address){

        bytes32  hash = keccak256(abi.encodePacked(bytes1(0xff),address(this), _salt,keccak256(_bytecode)));
        return address(uint160(uint(hash)));
    }

    function getbytecode(address _owner) external pure returns(bytes memory) {

        bytes memory bytecode = type(maxx).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_owner));
    }
}
