from django.shortcuts import render

# Create your views here.
from django.http import JsonResponse
from web3 import Web3
from eth_account import Account
from eth_gas_price import EthGasPrice
from .contracts import get_gas_price, main, IWETH_ABI, 
IUNISWAP_FACTORY_ABI

def swap_tokens(request, token_in, desired_tokens_out):
       gas_price = get_gas_price()
       web3 = Web3()
       account = Account.create()
       private_key = account.encryptingKey.hex()

weth = web3.eth.contract(address='0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2', abi=IWETH_ABI)
uniswapFactory = web3.eth.contract(address='0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f', abi=IUNISWAP_FACTORY_ABI)
wethContractAddress = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'
tokenInAddress = token_in
desiredTokensOut = int(desired_tokens_out)
nonce = weth.functions.getTransactionCountAtAddress(account.address).call()

transaction = weth.functions.approve(uniswapFactory.address, 
1000000).buildTransaction({'from': account.address, 'gasPrice': 
gas_price})
signed_tx = web3.eth.accounts.sign_transaction(transaction, private_key)
receipt = web3.eth.send_raw_transaction(signed_tx.rawTransaction)

return JsonResponse({'status': 'success', 'receipt':
                    receipt.toHex()}) if receipt else JsonResponse({'status': 'error'})