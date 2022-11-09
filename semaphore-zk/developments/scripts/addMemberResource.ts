import { Identity } from '@semaphore-protocol/identity';
import { Group } from '@semaphore-protocol/group';
import { ethers, utils } from 'ethers';

/**
 * - cli sample
 * npx ts-node developments/scripts/addMemberResource.ts
 * */ 
const createAddMemberResource = (): string => {
  const identity = new Identity();
  const group = new Group();
  group.addMember(identity.getCommitment());

  const identityCommitment = group.members[0];
  const username = ethers.utils.formatBytes32String('anon');
  const identityEntity = identity.toString();

  const abiCoder = new utils.AbiCoder();
  const resource = abiCoder.encode(
    ['uint256', 'bytes32', 'string'], [identityCommitment, username, identityEntity]
  );

  return resource;
}

(() => {
  console.log(createAddMemberResource());
})()