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

.PHONY: testnet
testnet: 
	forge script script/Counter.s.sol:CounterScript --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --private-key $(PRIVATE_KEY) --broadcast

.PHONY: testnet-greeter
testnet: 
	forge script script/Greeter.s.sol:GreeterScript --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --private-key $(PRIVATE_KEY) --broadcast

.PHONY: castcall
castcall:
	cast call 0xc070dc7bab214465fb69dff120358901adbaa625 "getCount()(uint256)" "" --rpc-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI)

.PHONY: testfork
testfork:
	forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --ffi -vvvvv

.PHONY: testhash
testhash:
	forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --libraries=contracts/Poseidon/Counter.sol:Hashes:0xe0A452533853310C371b50Bd91BB9DCC8961350F --ffi -vvvvv

.PHONY: test-hardhat-fork
test-hardhat-fork:
	forge test -c test/Counter.t.sol -m testSuccess_Hash --fork-url http://localhost:8545 --fork-block-number $(BLOCK) --libraries=node_modules/@zk-kit/incremental-merkle-tree.sol/Hashes.sol:PoseidonT3:0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 --ffi -vvvvv
