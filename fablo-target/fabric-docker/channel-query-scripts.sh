#!/usr/bin/env bash

source "$FABLO_NETWORK_ROOT/fabric-docker/scripts/channel-query-functions.sh"

set -eu

channelQuery() {
  echo "-> Channel query: " + "$@"

  if [ "$#" -eq 1 ]; then
    printChannelsHelp

  elif [ "$1" = "list" ] && [ "$2" = "wakilrektor" ] && [ "$3" = "peer0" ]; then

    peerChannelList "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041"

  elif
    [ "$1" = "list" ] && [ "$2" = "direktorat" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061"

  elif
    [ "$1" = "list" ] && [ "$2" = "direktorat" ] && [ "$3" = "peer1" ]
  then

    peerChannelList "cli.direktorat.unikom.ac.id" "peer1.direktorat.unikom.ac.id:7062"

  elif
    [ "$1" = "list" ] && [ "$2" = "programstudi" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081"

  elif
    [ "$1" = "list" ] && [ "$2" = "pic" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101"

  elif
    [ "$1" = "list" ] && [ "$2" = "mahasiswa" ] && [ "$3" = "peer0" ]
  then

    peerChannelList "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121"

  elif

    [ "$1" = "getinfo" ] && [ "$2" = "pendaftaran" ] && [ "$3" = "wakilrektor" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "pendaftaran" "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "wakilrektor" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "pendaftaran" "cli.wr.unikom.ac.id" "$TARGET_FILE" "peer0.wr.unikom.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "wakilrektor" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "pendaftaran" "cli.wr.unikom.ac.id" "${BLOCK_NAME}" "peer0.wr.unikom.ac.id:7041" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "pendaftaran" ] && [ "$3" = "pic" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "pendaftaran" "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "pic" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "pendaftaran" "cli.pic.unikom.ac.id" "$TARGET_FILE" "peer0.pic.unikom.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "pic" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "pendaftaran" "cli.pic.unikom.ac.id" "${BLOCK_NAME}" "peer0.pic.unikom.ac.id:7101" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "pendaftaran" ] && [ "$3" = "mahasiswa" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "pendaftaran" "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "mahasiswa" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "pendaftaran" "cli.mahasiswa.unikom.ac.id" "$TARGET_FILE" "peer0.mahasiswa.unikom.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$3" = "pendaftaran" ] && [ "$4" = "mahasiswa" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "pendaftaran" "cli.mahasiswa.unikom.ac.id" "${BLOCK_NAME}" "peer0.mahasiswa.unikom.ac.id:7121" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "nilai" ] && [ "$3" = "wakilrektor" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "nilai" "cli.wr.unikom.ac.id" "peer0.wr.unikom.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "nilai" ] && [ "$4" = "wakilrektor" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "nilai" "cli.wr.unikom.ac.id" "$TARGET_FILE" "peer0.wr.unikom.ac.id:7041"

  elif [ "$1" = "fetch" ] && [ "$3" = "nilai" ] && [ "$4" = "wakilrektor" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "nilai" "cli.wr.unikom.ac.id" "${BLOCK_NAME}" "peer0.wr.unikom.ac.id:7041" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "nilai" ] && [ "$3" = "direktorat" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "nilai" "cli.direktorat.unikom.ac.id" "peer0.direktorat.unikom.ac.id:7061"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "nilai" ] && [ "$4" = "direktorat" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "nilai" "cli.direktorat.unikom.ac.id" "$TARGET_FILE" "peer0.direktorat.unikom.ac.id:7061"

  elif [ "$1" = "fetch" ] && [ "$3" = "nilai" ] && [ "$4" = "direktorat" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "nilai" "cli.direktorat.unikom.ac.id" "${BLOCK_NAME}" "peer0.direktorat.unikom.ac.id:7061" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "nilai" ] && [ "$3" = "programstudi" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "nilai" "cli.prodi.unikom.ac.id" "peer0.prodi.unikom.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "nilai" ] && [ "$4" = "programstudi" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "nilai" "cli.prodi.unikom.ac.id" "$TARGET_FILE" "peer0.prodi.unikom.ac.id:7081"

  elif [ "$1" = "fetch" ] && [ "$3" = "nilai" ] && [ "$4" = "programstudi" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "nilai" "cli.prodi.unikom.ac.id" "${BLOCK_NAME}" "peer0.prodi.unikom.ac.id:7081" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "nilai" ] && [ "$3" = "pic" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "nilai" "cli.pic.unikom.ac.id" "peer0.pic.unikom.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "nilai" ] && [ "$4" = "pic" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "nilai" "cli.pic.unikom.ac.id" "$TARGET_FILE" "peer0.pic.unikom.ac.id:7101"

  elif [ "$1" = "fetch" ] && [ "$3" = "nilai" ] && [ "$4" = "pic" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "nilai" "cli.pic.unikom.ac.id" "${BLOCK_NAME}" "peer0.pic.unikom.ac.id:7101" "$TARGET_FILE"

  elif
    [ "$1" = "getinfo" ] && [ "$2" = "nilai" ] && [ "$3" = "mahasiswa" ] && [ "$4" = "peer0" ]
  then

    peerChannelGetInfo "nilai" "cli.mahasiswa.unikom.ac.id" "peer0.mahasiswa.unikom.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$2" = "config" ] && [ "$3" = "nilai" ] && [ "$4" = "mahasiswa" ] && [ "$5" = "peer0" ]; then
    TARGET_FILE=${6:-"$channel-config.json"}

    peerChannelFetchConfig "nilai" "cli.mahasiswa.unikom.ac.id" "$TARGET_FILE" "peer0.mahasiswa.unikom.ac.id:7121"

  elif [ "$1" = "fetch" ] && [ "$3" = "nilai" ] && [ "$4" = "mahasiswa" ] && [ "$5" = "peer0" ]; then
    BLOCK_NAME=$2
    TARGET_FILE=${6:-"$BLOCK_NAME.block"}

    peerChannelFetchBlock "nilai" "cli.mahasiswa.unikom.ac.id" "${BLOCK_NAME}" "peer0.mahasiswa.unikom.ac.id:7121" "$TARGET_FILE"

  else

    echo "$@"
    echo "$1, $2, $3, $4, $5, $6, $7, $#"
    printChannelsHelp
  fi

}

printChannelsHelp() {
  echo "Channel management commands:"
  echo ""

  echo "fablo channel list wakilrektor peer0"
  echo -e "\t List channels on 'peer0' of 'WakilRektor'".
  echo ""

  echo "fablo channel list direktorat peer0"
  echo -e "\t List channels on 'peer0' of 'Direktorat'".
  echo ""

  echo "fablo channel list direktorat peer1"
  echo -e "\t List channels on 'peer1' of 'Direktorat'".
  echo ""

  echo "fablo channel list programstudi peer0"
  echo -e "\t List channels on 'peer0' of 'ProgramStudi'".
  echo ""

  echo "fablo channel list pic peer0"
  echo -e "\t List channels on 'peer0' of 'PIC'".
  echo ""

  echo "fablo channel list mahasiswa peer0"
  echo -e "\t List channels on 'peer0' of 'Mahasiswa'".
  echo ""

  echo "fablo channel getinfo pendaftaran wakilrektor peer0"
  echo -e "\t Get channel info on 'peer0' of 'WakilRektor'".
  echo ""
  echo "fablo channel fetch config pendaftaran wakilrektor peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'WakilRektor'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> pendaftaran wakilrektor peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'WakilRektor'".
  echo ""

  echo "fablo channel getinfo pendaftaran pic peer0"
  echo -e "\t Get channel info on 'peer0' of 'PIC'".
  echo ""
  echo "fablo channel fetch config pendaftaran pic peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'PIC'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> pendaftaran pic peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'PIC'".
  echo ""

  echo "fablo channel getinfo pendaftaran mahasiswa peer0"
  echo -e "\t Get channel info on 'peer0' of 'Mahasiswa'".
  echo ""
  echo "fablo channel fetch config pendaftaran mahasiswa peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Mahasiswa'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> pendaftaran mahasiswa peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Mahasiswa'".
  echo ""

  echo "fablo channel getinfo nilai wakilrektor peer0"
  echo -e "\t Get channel info on 'peer0' of 'WakilRektor'".
  echo ""
  echo "fablo channel fetch config nilai wakilrektor peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'WakilRektor'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> nilai wakilrektor peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'WakilRektor'".
  echo ""

  echo "fablo channel getinfo nilai direktorat peer0"
  echo -e "\t Get channel info on 'peer0' of 'Direktorat'".
  echo ""
  echo "fablo channel fetch config nilai direktorat peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Direktorat'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> nilai direktorat peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Direktorat'".
  echo ""

  echo "fablo channel getinfo nilai programstudi peer0"
  echo -e "\t Get channel info on 'peer0' of 'ProgramStudi'".
  echo ""
  echo "fablo channel fetch config nilai programstudi peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'ProgramStudi'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> nilai programstudi peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'ProgramStudi'".
  echo ""

  echo "fablo channel getinfo nilai pic peer0"
  echo -e "\t Get channel info on 'peer0' of 'PIC'".
  echo ""
  echo "fablo channel fetch config nilai pic peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'PIC'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> nilai pic peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'PIC'".
  echo ""

  echo "fablo channel getinfo nilai mahasiswa peer0"
  echo -e "\t Get channel info on 'peer0' of 'Mahasiswa'".
  echo ""
  echo "fablo channel fetch config nilai mahasiswa peer0 [file-name.json]"
  echo -e "\t Download latest config block and save it. Uses first peer 'peer0' of 'Mahasiswa'".
  echo ""
  echo "fablo channel fetch <newest|oldest|block-number> nilai mahasiswa peer0 [file name]"
  echo -e "\t Fetch a block with given number and save it. Uses first peer 'peer0' of 'Mahasiswa'".
  echo ""

}
