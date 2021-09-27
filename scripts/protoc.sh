#!/bin/bash

INPUT_DIR="api/proto"
OUT_DIR="pkg/api"

for f in `find "${INPUT_DIR}" -name *.proto`; do
  base=`basename "${f}"`
  parent=`dirname "${f}"`
  dir=`echo "${f}" | sed -e "s|${INPUT_DIR}|${OUT_DIR}|"`
  out=`dirname "${dir}"`
  if [ ! -e "${out}" ]; then
    mkdir -p "${out}"
  fi

  protoc --proto_path=${parent} --go_out=${out} --go-grpc_out=${out} --go-grpc_opt=require_unimplemented_servers=true ${base}
done
