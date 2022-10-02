#!/bin/bash

while read line; do
  lib_name=$(echo "${line}" | awk -F' ' '{print $1}')
  lib_url=$(echo "${line}" | awk -F' ' '{print $2}')

  org_repo=${lib_url:19}

  commit=$(gh api /repos/${org_repo}/commits/main)
  if [ $? -ne 0 ]; then
    commit=$(gh api /repos/${org_repo}/commits/master)
  fi

  last_commit_date=$(echo "${commit}" | jq .commit.author.date)

  echo "${lib_name},${last_commit_date}"
done < "libs.list"
