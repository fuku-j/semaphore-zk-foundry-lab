import { Identity } from '@semaphore-protocol/identity';
import { Group } from '@semaphore-protocol/group';
import { ethers, utils } from 'ethers';

/**
 * @dev Create member resource
 * - cli sample
 * npx ts-node developments/scripts/semaphoreScripts/addMemberResource.ts
*/

const createAddMemberResource = (): string => {
  // Instantiate abi utils
  const abiUtils = new utils.AbiCoder();

  // Create new member identity
  const memberIdentity = new Identity();
  const memberIdentityEntity = memberIdentity.toString();

  // Create new group
  const group = new Group();
  group.addMember(memberIdentity.getCommitment());

  const output = abiUtils.encode(['uint256', 'string'], [group.members[0], memberIdentityEntity]);

  return output;
}

(() => {
  console.log(createAddMemberResource());
})()
