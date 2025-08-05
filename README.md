# MyStablecoin Infrastructure
A beginner-friendly stablecoin infrastructure built with Remix IDE and OpenZeppelin’s ERC-20 contract for a GitHub portfolio.

# Overview
This project implements a fiat-backed stablecoin with:
MyStablecoin: ERC-20 token with minting, burning, pausing, and permit functionality.
ReserveManager : Simulates fiat reserve management.
A simple HTML/JavaScript frontend for wallet interaction and minting.

# Setup
1. opened remix https://remix.ethereum.org
2. Created files in contracts folder:
    MyStablecoin.sol, ReserveManager.sol, and MyStablecoinTest.sol
3. Compiled with Solidity v0.8.27 in Remix Solidity Compiler
4. Test contracts using MyStablecoinTest.sol in the Solidity Unit Testing
5. Deployed to Remix VM (Prague)
6. For frontend demo:
   Copy the MyStablecoin deployed address and ABI from Remix.
   Update frontend/index.html with these values.
   Open index.html in a browser with MetaMask installed.
