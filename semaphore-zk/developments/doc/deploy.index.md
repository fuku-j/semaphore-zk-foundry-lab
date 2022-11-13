---
title: Deploy by foundry
---

## Deploy

### Summary

- Example for deploy by foundry.

### Step

 1. create contract
 2. create test code for contract
 3. create deploy script
 4. Running Anvil
 5. Deploy
    1. Deploy create contract to Anvil Blockchain.
    2. Deploy library contract to Anvil Blockchain.
 6. Unit test for deploy contract
    1. Use forge cast cli
    2. Use forge test cli
    3. Use forge test --fork-url cli
    4. Change use --libraries address after use forge test --fork-url cli

### Deploy contract address list by Anvil

 1. Deploy contract address list
    1. `0x5fbdb2315678afecb367f032d93f642f64180aa3`
    2. `0xe7f1725e7734ce288f8367e1bb143e90bb3f0512`
    3. `0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0`
 2. library address of Hashes
    1. `0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9`

### Example for cli

- `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` is Anvil private key

1. Example for Step_5

    - Step_5-1

          ```:shell
            forge script script/Counter.s.sol:CounterScript --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
          ```

    - Step_5-2

          ```:shell
            forge create --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 contracts/Poseidon/Hashes.sol:PoseidonT3
          ```

2. Example for Step_6

    - Step_6-1

          ```:shell
            cast call 0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0 "getCount()(uint256)" "" --rpc-url http://localhost:8545
          ```

    - Step_6-2

          ```:shell
            forge test --fork-url http://localhost:8545 --fork-block-number 3
          ```

    - Step_6-3

          ```:shell
            forge test --fork-url http://localhost:8545 --fork-block-number 3 --libraries=contracts/Poseidon/Counter.sol:Hashes:0xe7f1725e7734ce288f8367e1bb143e90bb3f0512 -vvvvv
          ```

    - Step_6-4

          ```:shell
            forge test --fork-url http://localhost:8545 --fork-block-number 3 --libraries=contracts/Counter.sol:Hashes:0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 -vvvvv
          ```

### Unit test for Goerli Testnet

##### Hashes.sol

✅ Hash: 0x32154516feb554b4d7378780b011a24119ac1a8dfbe0bc2d219dcf3f0a9fa0e5
Contract Address: 0x65ed2b705e8843e55ee423574f1759e29a5aae65
Block: 7945269
Paid: 0.000393996001575984 ETH (131332 gas * 3.000000012 gwei)

##### IncremnetCounter.sol

✅ Hash: 0xcc118d76c2300069970703188c240dc837c05549fb4b88b443690ecdcc29d0aa
Contract Address: 0x1e1a9b4b2c28d448fe141779e1fd36fd2703f914
Block: 7945269
Paid: 0.000349500001398 ETH (116500 gas * 3.000000012 gwei)

##### Counter.sol

✅ Hash: 0x6229157111e7a85cf1d95209dc68911a6c9e1487ee282d8a1a77035eeada2447
Contract Address: 0xc070dc7bab214465fb69dff120358901adbaa625
Block: 7945269
Paid: 0.00071626500286506 ETH (238755 gas * 3.000000012 gwei)

          ```:shell
            cast call 0xc070dc7bab214465fb69dff120358901adbaa625 "getCount()(uint256)" "" --rpc-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI)
          ```

          ```:shell
            forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269
          ```

          ```:shell
            forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945122 --libraries=contracts/Poseidon/Counter.sol:Hashes:0xe0A452533853310C371b50Bd91BB9DCC8961350F
          ```
