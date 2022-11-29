import { Group } from '@semaphore-protocol/group';
import { Identity } from '@semaphore-protocol/identity';
import { BigNumber, utils } from 'ethers';
import { generateProof, packToSolidityProof } from '@semaphore-protocol/proof';

import yargs from 'yargs';

const args = yargs
  .command("* <message>", "print a message received as an argument")
  .parseSync()

/**
 * - cli sample
 * npx ts-node developments/scripts/semaphoreScripts/verifyProofResource.ts "["286b2efa2339937b0acf642968f4bf71913f7edc927d8bcfffee4efc803d4b","5c705e0e3434d12c70820813f0bd567d804cda2a6aa3f80d328185c16914c4"]"
 * */ 

const createVerifyProof = async (args: string): Promise<string> => {
  const identity = new Identity(args);
  const group = new Group();

  const groupId = BigNumber.from(42).toBigInt();
  group.addMember(identity.getCommitment());
  
  const memberAddress = '0x0e4b26581262b88166D5ae04CCD4B9f70D8f5eEd';
  const addrHashed = utils.keccak256(utils.solidityPack(["address"], [memberAddress]));

  const wasmFilePath = './static/semaphore.wasm';
  const zkeyFilePath = './static/semaphore.zkey';
  
  const fullProof = await generateProof(identity, group, groupId, addrHashed, {
    wasmFilePath,
    zkeyFilePath,
  });

  const solidityProof = packToSolidityProof(fullProof.proof);

  const abiCoder = new utils.AbiCoder();
  const resource = abiCoder.encode(
    ['bytes32', 'uint256', 'uint256', 'uint256[8]'],
    [addrHashed, fullProof.publicSignals.merkleRoot, fullProof.publicSignals.nullifierHash, solidityProof]
  );
  
  return resource;
}

(async () => {
  console.log(await createVerifyProof(args.message as string));

  process.exit(0);
})();
