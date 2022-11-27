include .env

.PHONY: build
build:
	forge build

.PHONY: test
test:
	forge test

.PHONY: local
local:
	anvil

.PHONY: localnet
localnet:
	forge script script/Counter.s.sol:CounterScript --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast

.PHONY: testnet-counter
testnet-counter: 
	forge script script/Counter.s.sol:CounterScript --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --private-key $(PRIVATE_KEY) --broadcast

.PHONY: testnet-greeter
testnet-greeter: 
	forge script script/Greeter.s.sol:GreeterScript --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --private-key $(PRIVATE_KEY) --broadcast

.PHONY: castcall
castcall:
	cast call 0xc070dc7bab214465fb69dff120358901adbaa625 "getCount()(uint256)" "" --rpc-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI)

.PHONY: testnet-fork
testnet-fork:
	forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --ffi -vvvvv

.PHONY: testnet-counter
testnet-counter:
	forge test -c test/Counter.t.sol -m testSuccess_Hash --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --libraries=node_modules/@zk-kit/incremental-merkle-tree.sol/Hashes.sol:PoseidonT3:0x2a96c5696F85e3d2aa918496806B5c5a4D93E099 --ffi -vvvvv

.PHONY: test-hardhat-fork
test-hardhat-fork:
	forge test -c test/Counter.t.sol -m testSuccess_Hash --fork-url http://localhost:8545 --fork-block-number $(BLOCK) --libraries=node_modules/@zk-kit/incremental-merkle-tree.sol/Hashes.sol:PoseidonT3:0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9 --ffi -vvvvv

.PHONY: testnet-hardhat-fork
testnet-hardhat-fork:
	forge test -c test/Greeter.t.sol -m testSuccess_greet --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 6976725 --libraries=node_modules/@zk-kit/incremental-merkle-tree.sol/Hashes.sol:PoseidonT3:0x2a96c5696F85e3d2aa918496806B5c5a4D93E099 --ffi -vvvvv
