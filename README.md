# semaphore-zk-foundry-lab

## Summary

- I try Unit test for semaphore libraries by foundry.

### Setup

 1. `yarn`

### References

- [Semaphore quick start](https://semaphore.appliedzkp.org/docs/quick-setup)

### Unit Test CLI Commands

 1. `forge test -c test/Greeter.t.sol -m testSuccess_joinGroup --ffi -vvvvv` for joinGroup methods.
 2. `forge test -c test/Greeter.t.sol -m testSuccess_greet --ffi -vvvvv` for greet methods.

### Scripts for Unit test for addMember and verifyProof

 1. addMemberResource.ts
 2. verifyProofResource.ts

## ISSUE

- can not insert to value for merkleTreeRoot by addMember methods.
  - Evidence for Unit test.

 ```:shell
 emit MemberAdded(groupId: 42, index: 0, identityCommitment: 2502365174281412056992067175983571336820898053119021946983960918307942123032, merkleTreeRoot: 0)
 ```

### Other
