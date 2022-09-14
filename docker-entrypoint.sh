#!/bin/bash
set -ex

BSC_CONFIG=${BSC_HOME}/config/config.toml
BSC_GENESIS=${BSC_HOME}/config/genesis.json

# Init genesis state if geth not exist
DATA_DIR=$(cat ${BSC_CONFIG} | grep -A1 '\[Node\]' | grep -oP '\"\K.*?(?=\")')
DATA_DIR=$(cat ${BSC_CONFIG} | grep -A1 '\[Node\]' | grep -oP '\"\K.*?(?=\")')
echo "DATADIR $DATA_DIR";

GETH_DIR=${DATA_DIR}/geth
if [ ! -d "$GETH_DIR" ]; then
  echo "INIT BLOCKCHAIN";
  geth --datadir ${DATA_DIR} init ${BSC_GENESIS}
fi

exec "geth" "--config" ${BSC_CONFIG} --ws --ws.origins=* --cache 18000 --rpc.allow-unprotected-txs --txlookuplimit 0 "$@"
