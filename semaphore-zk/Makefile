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

.PHONY: castcall
castcall:
	cast call 0xc070dc7bab214465fb69dff120358901adbaa625 "getCount()(uint256)" "" --rpc-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI)

.PHONY: testfork
testfork:
	forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --ffi -vvvvv

.PHONY: testhash
testhash:
	forge test --fork-url https://goerli.infura.io/v3/$(RPC_ENDPOINT_URI) --fork-block-number 7945269 --libraries=contracts/Poseidon/Counter.sol:Hashes:0xe0A452533853310C371b50Bd91BB9DCC8961350F --ffi -vvvvv