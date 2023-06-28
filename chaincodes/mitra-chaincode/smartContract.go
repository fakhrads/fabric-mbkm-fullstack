/*
SPDX-License-Identifier: Apache-2.0
*/

package main

import (
	"log"

	mitra "mitra-chaincode/contract"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func main() {
	abacSmartContract, err := contractapi.NewChaincode(&mitra.SmartContract{})
	if err != nil {
		log.Panicf("Error creating mitra chaincode: %v", err)
	}

	if err := abacSmartContract.Start(); err != nil {
		log.Panicf("Error starting mitra chaincode: %v", err)
	}
}
