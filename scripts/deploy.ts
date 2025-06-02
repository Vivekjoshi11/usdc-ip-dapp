// scripts/deploy.ts
import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const USDC = await ethers.getContractFactory("MockUSDC");
  const usdc = await USDC.deploy();
  await usdc.waitForDeployment();
  console.log("✅ MockUSDC deployed to:", await usdc.getAddress());

  const IPToken = await ethers.getContractFactory("IPToken");
  const ipToken = await IPToken.deploy();
  await ipToken.waitForDeployment();
  console.log("✅ IPToken deployed to:", await ipToken.getAddress());

  const RampConversion = await ethers.getContractFactory("RampConversion");
  const ramp = await RampConversion.deploy(
    await usdc.getAddress(),
    await ipToken.getAddress()
  );
  await ramp.waitForDeployment();
  console.log("✅ RampConversion deployed to:", await ramp.getAddress());

//   await ipToken.transferOwnership(await ramp.getAddress());
  console.log("🔁 Transferred IPToken ownership to Ramp");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
