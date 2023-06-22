#!/usr/bin/env bash

generateArtifacts() {
  printHeadline "Generating basic configs" "U1F913"

  printItalics "Generating crypto material for Unikom" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-unikom.yaml" "peerOrganizations/unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for WakilRektor" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-wakilrektor.yaml" "peerOrganizations/wr.unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Direktorat" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-direktorat.yaml" "peerOrganizations/direktorat.unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for ProgramStudi" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-programstudi.yaml" "peerOrganizations/prodi.unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for PIC" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-pic.yaml" "peerOrganizations/pic.unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating crypto material for Mahasiswa" "U1F512"
  certsGenerate "$FABLO_NETWORK_ROOT/fabric-config" "crypto-config-mahasiswa.yaml" "peerOrganizations/mahasiswa.unikom.ac.id" "$FABLO_NETWORK_ROOT/fabric-config/crypto-config/"

  printItalics "Generating genesis block for group unikom" "U1F3E0"
  genesisBlockCreate "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config" "UnikomGenesis"

  # Create directory for chaincode packages to avoid permission errors on linux
  mkdir -p "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"
}

startNetwork() {
  printHeadline "Starting network" "U1F680"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose up -d)
  sleep 4
}

generateChannelsArtifacts() {
  printHeadline "Generating config for 'pendaftaran'" "U1F913"
  createChannelTx "pendaftaran" "$FABLO_NETWORK_ROOT/fabric-config" "Pendaftaran" "$FABLO_NETWORK_ROOT/fabric-config/config"
  printHeadline "Generating config for 'nilai'" "U1F913"
  createChannelTx "nilai" "$FABLO_NETWORK_ROOT/fabric-config" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config/config"
}

installChannels() {
  printHeadline "Creating 'pendaftaran' on WakilRektor/peer0" "U1F63B"
  docker exec -i cli.wr.unikom.ac.id bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'pendaftaran' 'WakilRektorMSP' 'peer0.wr.unikom.ac.id:7041' 'crypto/users/Admin@wr.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"

  printItalics "Joining 'pendaftaran' on  PIC/peer0" "U1F638"
  docker exec -i cli.pic.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'pendaftaran' 'PICMSP' 'peer0.pic.unikom.ac.id:7101' 'crypto/users/Admin@pic.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
  printItalics "Joining 'pendaftaran' on  Mahasiswa/peer0" "U1F638"
  docker exec -i cli.mahasiswa.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'pendaftaran' 'MahasiswaMSP' 'peer0.mahasiswa.unikom.ac.id:7121' 'crypto/users/Admin@mahasiswa.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
  printHeadline "Creating 'nilai' on WakilRektor/peer0" "U1F63B"
  docker exec -i cli.wr.unikom.ac.id bash -c "source scripts/channel_fns.sh; createChannelAndJoin 'nilai' 'WakilRektorMSP' 'peer0.wr.unikom.ac.id:7041' 'crypto/users/Admin@wr.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"

  printItalics "Joining 'nilai' on  Direktorat/peer0" "U1F638"
  docker exec -i cli.direktorat.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'nilai' 'DirektoratMSP' 'peer0.direktorat.unikom.ac.id:7061' 'crypto/users/Admin@direktorat.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
  printItalics "Joining 'nilai' on  ProgramStudi/peer0" "U1F638"
  docker exec -i cli.prodi.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'nilai' 'ProgramStudiMSP' 'peer0.prodi.unikom.ac.id:7081' 'crypto/users/Admin@prodi.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
  printItalics "Joining 'nilai' on  PIC/peer0" "U1F638"
  docker exec -i cli.pic.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'nilai' 'PICMSP' 'peer0.pic.unikom.ac.id:7101' 'crypto/users/Admin@pic.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
  printItalics "Joining 'nilai' on  Mahasiswa/peer0" "U1F638"
  docker exec -i cli.mahasiswa.unikom.ac.id bash -c "source scripts/channel_fns.sh; fetchChannelAndJoin 'nilai' 'MahasiswaMSP' 'peer0.mahasiswa.unikom.ac.id:7121' 'crypto/users/Admin@mahasiswa.unikom.ac.id/msp' 'orderer0.unikom.unikom.ac.id:7030';"
}

installChaincodes() {
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'registry-chaincode'" "U1F60E"
    chaincodeBuild "registry-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode" "12"
    chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" "node" printHeadline "Installing 'registry-chaincode' for WakilRektor" "U1F60E"
    chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" ""
    chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'registry-chaincode' for PIC" "U1F60E"
    chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "registry-chaincode" "$version" ""
    chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'registry-chaincode' for Mahasiswa" "U1F60E"
    chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "registry-chaincode" "$version" ""
    chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'registry-chaincode' on channel 'pendaftaran' as 'WakilRektor'" "U1F618"
    chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""
  else
    echo "Warning! Skipping chaincode 'registry-chaincode' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode'"
  fi
  if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode")" ]; then
    local version="0.0.1"
    printHeadline "Packaging chaincode 'score-chaincode'" "U1F60E"
    chaincodeBuild "score-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode" "12"
    chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" "node" printHeadline "Installing 'score-chaincode' for WakilRektor" "U1F60E"
    chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" ""
    chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'score-chaincode' for Direktorat" "U1F60E"
    chaincodeInstall "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "score-chaincode" "$version" ""
    chaincodeApprove "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'score-chaincode' for ProgramStudi" "U1F60E"
    chaincodeInstall "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "score-chaincode" "$version" ""
    chaincodeApprove "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'score-chaincode' for PIC" "U1F60E"
    chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "score-chaincode" "$version" ""
    chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Installing 'score-chaincode' for Mahasiswa" "U1F60E"
    chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "score-chaincode" "$version" ""
    chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'score-chaincode' on channel 'nilai' as 'WakilRektor'" "U1F618"
    chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.direktorat.unikom.ac.id:7061,peer0.prodi.unikom.ac.id:7081,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""
  else
    echo "Warning! Skipping chaincode 'score-chaincode' installation. Chaincode directory is empty."
    echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode'"
  fi

}

installChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "registry-chaincode" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode")" ]; then
      printHeadline "Packaging chaincode 'registry-chaincode'" "U1F60E"
      chaincodeBuild "registry-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode" "12"
      chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" "node" printHeadline "Installing 'registry-chaincode' for WakilRektor" "U1F60E"
      chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'registry-chaincode' for PIC" "U1F60E"
      chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'registry-chaincode' for Mahasiswa" "U1F60E"
      chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'registry-chaincode' on channel 'pendaftaran' as 'WakilRektor'" "U1F618"
      chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'registry-chaincode' install. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode'"
    fi
  fi
  if [ "$chaincodeName" = "score-chaincode" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode")" ]; then
      printHeadline "Packaging chaincode 'score-chaincode'" "U1F60E"
      chaincodeBuild "score-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode" "12"
      chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" "node" printHeadline "Installing 'score-chaincode' for WakilRektor" "U1F60E"
      chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" ""
      chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for Direktorat" "U1F60E"
      chaincodeInstall "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "score-chaincode" "$version" ""
      chaincodeApprove "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for ProgramStudi" "U1F60E"
      chaincodeInstall "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "score-chaincode" "$version" ""
      chaincodeApprove "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for PIC" "U1F60E"
      chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "score-chaincode" "$version" ""
      chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for Mahasiswa" "U1F60E"
      chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "score-chaincode" "$version" ""
      chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'score-chaincode' on channel 'nilai' as 'WakilRektor'" "U1F618"
      chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.direktorat.unikom.ac.id:7061,peer0.prodi.unikom.ac.id:7081,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'score-chaincode' install. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode'"
    fi
  fi
}

runDevModeChaincode() {
  local chaincodeName=$1
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "registry-chaincode" ]; then
    local version="0.0.1"
    printHeadline "Approving 'registry-chaincode' for WakilRektor (dev mode)" "U1F60E"
    chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'registry-chaincode' for PIC (dev mode)" "U1F60E"
    chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "pendaftaran" "registry-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'registry-chaincode' for Mahasiswa (dev mode)" "U1F60E"
    chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "pendaftaran" "registry-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'registry-chaincode' on channel 'pendaftaran' as 'WakilRektor' (dev mode)" "U1F618"
    chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

  fi
  if [ "$chaincodeName" = "score-chaincode" ]; then
    local version="0.0.1"
    printHeadline "Approving 'score-chaincode' for WakilRektor (dev mode)" "U1F60E"
    chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'score-chaincode' for Direktorat (dev mode)" "U1F60E"
    chaincodeApprove "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'score-chaincode' for ProgramStudi (dev mode)" "U1F60E"
    chaincodeApprove "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'score-chaincode' for PIC (dev mode)" "U1F60E"
    chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printHeadline "Approving 'score-chaincode' for Mahasiswa (dev mode)" "U1F60E"
    chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
    printItalics "Committing chaincode 'score-chaincode' on channel 'nilai' as 'WakilRektor' (dev mode)" "U1F618"
    chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "0.0.1" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.direktorat.unikom.ac.id:7061,peer0.prodi.unikom.ac.id:7081,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

  fi
}

upgradeChaincode() {
  local chaincodeName="$1"
  if [ -z "$chaincodeName" ]; then
    echo "Error: chaincode name is not provided"
    exit 1
  fi

  local version="$2"
  if [ -z "$version" ]; then
    echo "Error: chaincode version is not provided"
    exit 1
  fi

  if [ "$chaincodeName" = "registry-chaincode" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode")" ]; then
      printHeadline "Packaging chaincode 'registry-chaincode'" "U1F60E"
      chaincodeBuild "registry-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode" "12"
      chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" "node" printHeadline "Installing 'registry-chaincode' for WakilRektor" "U1F60E"
      chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'registry-chaincode' for PIC" "U1F60E"
      chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'registry-chaincode' for Mahasiswa" "U1F60E"
      chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "registry-chaincode" "$version" ""
      chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'registry-chaincode' on channel 'pendaftaran' as 'WakilRektor'" "U1F618"
      chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "pendaftaran" "registry-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'registry-chaincode' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/registry-chaincode'"
    fi
  fi
  if [ "$chaincodeName" = "score-chaincode" ]; then
    if [ -n "$(ls "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode")" ]; then
      printHeadline "Packaging chaincode 'score-chaincode'" "U1F60E"
      chaincodeBuild "score-chaincode" "node" "$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode" "12"
      chaincodePackage "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" "node" printHeadline "Installing 'score-chaincode' for WakilRektor" "U1F60E"
      chaincodeInstall "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "score-chaincode" "$version" ""
      chaincodeApprove "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for Direktorat" "U1F60E"
      chaincodeInstall "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "score-chaincode" "$version" ""
      chaincodeApprove "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for ProgramStudi" "U1F60E"
      chaincodeInstall "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "score-chaincode" "$version" ""
      chaincodeApprove "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for PIC" "U1F60E"
      chaincodeInstall "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "score-chaincode" "$version" ""
      chaincodeApprove "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printHeadline "Installing 'score-chaincode' for Mahasiswa" "U1F60E"
      chaincodeInstall "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "score-chaincode" "$version" ""
      chaincodeApprove "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" ""
      printItalics "Committing chaincode 'score-chaincode' on channel 'nilai' as 'WakilRektor'" "U1F618"
      chaincodeCommit "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041" "nilai" "score-chaincode" "$version" "orderer0.unikom.unikom.ac.id:7030" "" "false" "" "peer0.wr.unikom.ac.id:7041,peer0.direktorat.unikom.ac.id:7061,peer0.prodi.unikom.ac.id:7081,peer0.pic.unikom.ac.id:7101,peer0.mahasiswa.unikom.ac.id:7121" "" ""

    else
      echo "Warning! Skipping chaincode 'score-chaincode' upgrade. Chaincode directory is empty."
      echo "Looked in dir: '$CHAINCODES_BASE_DIR/./chaincodes/score-chaincode'"
    fi
  fi
}

notifyOrgsAboutChannels() {
  printHeadline "Creating new channel config blocks" "U1F537"
  createNewChannelUpdateTx "pendaftaran" "WakilRektorMSP" "Pendaftaran" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "pendaftaran" "PICMSP" "Pendaftaran" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "pendaftaran" "MahasiswaMSP" "Pendaftaran" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "nilai" "WakilRektorMSP" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "nilai" "DirektoratMSP" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "nilai" "ProgramStudiMSP" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "nilai" "PICMSP" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"
  createNewChannelUpdateTx "nilai" "MahasiswaMSP" "Nilai" "$FABLO_NETWORK_ROOT/fabric-config" "$FABLO_NETWORK_ROOT/fabric-config/config"

  printHeadline "Notyfing orgs about channels" "U1F4E2"
  notifyOrgAboutNewChannel "pendaftaran" "WakilRektorMSP" "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "pendaftaran" "PICMSP" "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "pendaftaran" "MahasiswaMSP" "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "nilai" "WakilRektorMSP" "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "nilai" "DirektoratMSP" "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "nilai" "ProgramStudiMSP" "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "nilai" "PICMSP" "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"
  notifyOrgAboutNewChannel "nilai" "MahasiswaMSP" "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id" "orderer0.unikom.unikom.ac.id:7030"

  printHeadline "Deleting new channel config blocks" "U1F52A"
  deleteNewChannelUpdateTx "pendaftaran" "WakilRektorMSP" "cli.wr.unikom.ac.id"
  deleteNewChannelUpdateTx "pendaftaran" "PICMSP" "cli.pic.unikom.ac.id"
  deleteNewChannelUpdateTx "pendaftaran" "MahasiswaMSP" "cli.mahasiswa.unikom.ac.id"
  deleteNewChannelUpdateTx "nilai" "WakilRektorMSP" "cli.wr.unikom.ac.id"
  deleteNewChannelUpdateTx "nilai" "DirektoratMSP" "cli.direktorat.unikom.ac.id"
  deleteNewChannelUpdateTx "nilai" "ProgramStudiMSP" "cli.prodi.unikom.ac.id"
  deleteNewChannelUpdateTx "nilai" "PICMSP" "cli.pic.unikom.ac.id"
  deleteNewChannelUpdateTx "nilai" "MahasiswaMSP" "cli.mahasiswa.unikom.ac.id"
}

printStartSuccessInfo() {
  printHeadline "Done! Enjoy your fresh network" "U1F984"
}

stopNetwork() {
  printHeadline "Stopping network" "U1F68F"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose stop)
  sleep 4
}

networkDown() {
  printHeadline "Destroying network" "U1F916"
  (cd "$FABLO_NETWORK_ROOT"/fabric-docker && docker-compose down)

  printf "\nRemoving chaincode containers & images... \U1F5D1 \n"
  for container in $(docker ps -a | grep "dev-peer0.wr.unikom.ac.id-registry-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.wr.unikom.ac.id-registry-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.pic.unikom.ac.id-registry-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.pic.unikom.ac.id-registry-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.mahasiswa.unikom.ac.id-registry-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.mahasiswa.unikom.ac.id-registry-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.wr.unikom.ac.id-score-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.wr.unikom.ac.id-score-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.direktorat.unikom.ac.id-score-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.direktorat.unikom.ac.id-score-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.prodi.unikom.ac.id-score-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.prodi.unikom.ac.id-score-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.pic.unikom.ac.id-score-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.pic.unikom.ac.id-score-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done
  for container in $(docker ps -a | grep "dev-peer0.mahasiswa.unikom.ac.id-score-chaincode" | awk '{print $1}'); do
    echo "Removing container $container..."
    docker rm -f "$container" || echo "docker rm of $container failed. Check if all fabric dockers properly was deleted"
  done
  for image in $(docker images "dev-peer0.mahasiswa.unikom.ac.id-score-chaincode*" -q); do
    echo "Removing image $image..."
    docker rmi "$image" || echo "docker rmi of $image failed. Check if all fabric dockers properly was deleted"
  done

  printf "\nRemoving generated configs... \U1F5D1 \n"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/crypto-config"
  rm -rf "$FABLO_NETWORK_ROOT/fabric-config/chaincode-packages"

  printHeadline "Done! Network was purged" "U1F5D1"
}
