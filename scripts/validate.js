#!/usr/bin/env node
const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");
const coaSource = fs.readFileSync(path.join(root, "src/ChartOfAccounts.elm"), "utf8");
const txnSource = fs.readFileSync(path.join(root, "src/JanuaryTransactions.elm"), "utf8");

// Extract account numbers from ChartOfAccounts (e.g. "Account 1010")
const accountNumbers = new Set(
  [...coaSource.matchAll(/Account (\d+)/g)].map((m) => m[1])
);

// Extract debit/credit account numbers from transactions
// They appear as the 3rd and 4th args in each Transaction constructor call
const txnMatches = [
  ...txnSource.matchAll(/Transaction "([^"]+)"\s*"([^"]+)"\s*(\d+)\s*(\d+)/g),
];

let errors = 0;

for (const m of txnMatches) {
  const [, date, desc, debit, credit] = m;
  if (!accountNumbers.has(debit)) {
    console.log(`BAD DEBIT  ${debit} in "${date}: ${desc}"`);
    errors++;
  }
  if (!accountNumbers.has(credit)) {
    console.log(`BAD CREDIT ${credit} in "${date}: ${desc}"`);
    errors++;
  }
}

if (errors === 0) {
  console.log(`All ${txnMatches.length} transactions reference valid accounts.`);
} else {
  console.log(`\n${errors} error(s) found.`);
  process.exit(1);
}
