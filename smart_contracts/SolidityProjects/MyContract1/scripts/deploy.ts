import * as hh from "hardhat";

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = hh.ethers.utils.parseEther("1");

  const Lock = await hh.ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await lock.deployed();

  const Obj1 = await hh.ethers.getContractFactory("MyToken");
  const obj1 = await Lock.deploy(unlockTime, { value: lockedAmount });

  await obj1.deployed();

  const Obj2 = await hh.ethers.getContractFactory("Migrations");
  const obj2 = await Lock.deploy(unlockTime, { value: lockedAmount });

  await obj2.deployed();

  const Obj3 = await hh.ethers.getContractFactory("Pool");
  const obj3 = await Lock.deploy(unlockTime, { value: lockedAmount });

  await obj3.deployed();

  const Obj4 = await hh.ethers.getContractFactory("Swap");
  const obj4 = await Lock.deploy(unlockTime, { value: lockedAmount });

  await obj4.deployed();

  console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
