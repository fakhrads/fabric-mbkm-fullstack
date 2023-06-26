/*
SPDX-License-Identifier: Apache-2.0
*/

package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	mitra "github.com/fakhrads/fabric-mbkm-fullstack/chaincodes/mitra-chaincode/contract/contract"
)

func main() {
	abacSmartContract, err := contractapi.NewChaincode(&mitra.SmartContract{})
	if err != nil {
		log.Panicf("Error creating abac chaincode: %v", err)
	}

	if err := abacSmartContract.Start(); err != nil {
		log.Panicf("Error starting abac chaincode: %v", err)
	}
}
