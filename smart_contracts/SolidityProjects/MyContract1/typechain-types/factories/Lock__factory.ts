/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Signer,
  utils,
  Contract,
  ContractFactory,
  PayableOverrides,
  BigNumberish,
} from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../common";
import type { Lock, LockInterface } from "../Lock";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_unlockTime",
        type: "uint256",
      },
    ],
    stateMutability: "payable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "when",
        type: "uint256",
      },
    ],
    name: "Withdrawal",
    type: "event",
  },
  {
    inputs: [],
    name: "owner",
    outputs: [
      {
        internalType: "address payable",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "unlockTime",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "withdraw",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405260405162000e0938038062000e098339818101604052810190620000299190620003bb565b8042106200006e576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401620000659062000474565b60405180910390fd5b8060008190555033600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550620001026040518060400160405280601481526020017f626c6f636b2e74696d657374616d70203d20256f00000000000000000000000081525042620001c560201b620002561760201c565b620001506040518060400160405280600f81526020017f756e6c6f636b54696d65203d20256f0000000000000000000000000000000000815250600054620001c560201b620002561760201c565b620001be6040518060400160405280600a81526020017f6f776e6572203d20256f00000000000000000000000000000000000000000000815250600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff166200026b60201b620002f21760201c565b506200060c565b620002678282604051602401620001de92919062000530565b6040516020818303038152906040527fb60e72cc000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff83818316178352505050506200031160201b60201c565b5050565b6200030d828260405160240162000284929190620005a9565b6040516020818303038152906040527f319af333000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff83818316178352505050506200031160201b60201c565b5050565b6200033781620003326200033a60201b6200038e176200035b60201b60201c565b60201c565b50565b60006a636f6e736f6c652e6c6f679050600080835160208501845afa505050565b6200036f60201b6200047317819050919050565b62000379620005dd565b565b600080fd5b6000819050919050565b620003958162000380565b8114620003a157600080fd5b50565b600081519050620003b5816200038a565b92915050565b600060208284031215620003d457620003d36200037b565b5b6000620003e484828501620003a4565b91505092915050565b600082825260208201905092915050565b7f556e6c6f636b2074696d652073686f756c6420626520696e207468652066757460008201527f7572650000000000000000000000000000000000000000000000000000000000602082015250565b60006200045c602383620003ed565b91506200046982620003fe565b604082019050919050565b600060208201905081810360008301526200048f816200044d565b9050919050565b600081519050919050565b60005b83811015620004c1578082015181840152602081019050620004a4565b60008484015250505050565b6000601f19601f8301169050919050565b6000620004eb8262000496565b620004f78185620003ed565b935062000509818560208601620004a1565b6200051481620004cd565b840191505092915050565b6200052a8162000380565b82525050565b600060408201905081810360008301526200054c8185620004de565b90506200055d60208301846200051f565b9392505050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000620005918262000564565b9050919050565b620005a38162000584565b82525050565b60006040820190508181036000830152620005c58185620004de565b9050620005d6602083018462000598565b9392505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052605160045260246000fd5b6107ed806200061c6000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c8063251c1aa3146100465780633ccfd60b146100645780638da5cb5b1461006e575b600080fd5b61004e61008c565b60405161005b9190610496565b60405180910390f35b61006c610092565b005b610076610230565b60405161008391906104f2565b60405180910390f35b60005481565b6100b76040518060600160405280602b815260200161078d602b9139600054426103af565b6000544210156100fc576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016100f39061056a565b60405180910390fd5b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161461018c576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610183906105d6565b60405180910390fd5b7fbf2ed60bd5b5965d685680c01195c9514e4382e28e3a5a2d2d5244bf59411b9347426040516101bd9291906105f6565b60405180910390a1600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc479081150290604051600060405180830381858888f1935050505015801561022d573d6000803e3d6000fd5b50565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6102ee828260405160240161026c92919061069e565b6040516020818303038152906040527fb60e72cc000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff838183161783525050505061044e565b5050565b61038a82826040516024016103089291906106ef565b6040516020818303038152906040527f319af333000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff838183161783525050505061044e565b5050565b60006a636f6e736f6c652e6c6f679050600080835160208501845afa505050565b6104498383836040516024016103c79392919061071f565b6040516020818303038152906040527fca47c4eb000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff838183161783525050505061044e565b505050565b6104658161045d61038e610468565b63ffffffff16565b50565b610473819050919050565b61047b61075d565b565b6000819050919050565b6104908161047d565b82525050565b60006020820190506104ab6000830184610487565b92915050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006104dc826104b1565b9050919050565b6104ec816104d1565b82525050565b600060208201905061050760008301846104e3565b92915050565b600082825260208201905092915050565b7f596f752063616e27742077697468647261772079657400000000000000000000600082015250565b600061055460168361050d565b915061055f8261051e565b602082019050919050565b6000602082019050818103600083015261058381610547565b9050919050565b7f596f75206172656e277420746865206f776e6572000000000000000000000000600082015250565b60006105c060148361050d565b91506105cb8261058a565b602082019050919050565b600060208201905081810360008301526105ef816105b3565b9050919050565b600060408201905061060b6000830185610487565b6106186020830184610487565b9392505050565b600081519050919050565b60005b8381101561064857808201518184015260208101905061062d565b60008484015250505050565b6000601f19601f8301169050919050565b60006106708261061f565b61067a818561050d565b935061068a81856020860161062a565b61069381610654565b840191505092915050565b600060408201905081810360008301526106b88185610665565b90506106c76020830184610487565b9392505050565b60006106d9826104b1565b9050919050565b6106e9816106ce565b82525050565b600060408201905081810360008301526107098185610665565b905061071860208301846106e0565b9392505050565b600060608201905081810360008301526107398186610665565b90506107486020830185610487565b6107556040830184610487565b949350505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052605160045260246000fdfe556e6c6f636b2074696d6520697320256f20616e6420626c6f636b2074696d657374616d7020697320256fa26469706673582212209af1ba34d6b50a789a7dd78b9efd08268339dd7ca5555e400c43946ee386466064736f6c63430008110033";

type LockConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: LockConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Lock__factory extends ContractFactory {
  constructor(...args: LockConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    _unlockTime: PromiseOrValue<BigNumberish>,
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): Promise<Lock> {
    return super.deploy(_unlockTime, overrides || {}) as Promise<Lock>;
  }
  override getDeployTransaction(
    _unlockTime: PromiseOrValue<BigNumberish>,
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(_unlockTime, overrides || {});
  }
  override attach(address: string): Lock {
    return super.attach(address) as Lock;
  }
  override connect(signer: Signer): Lock__factory {
    return super.connect(signer) as Lock__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): LockInterface {
    return new utils.Interface(_abi) as LockInterface;
  }
  static connect(address: string, signerOrProvider: Signer | Provider): Lock {
    return new Contract(address, _abi, signerOrProvider) as Lock;
  }
}
