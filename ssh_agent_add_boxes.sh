#!/bin/bash
##
##
##

vagrant ssh-config \
  | grep IdentityFile \
  | sed -e s/IdentityFile// -e s/\"//g \
  > ${TMPDIR}/keylist.$$

while read -r line ; do
  ssh-add -q "$line"
done < ${TMPDIR}/keylist.$$

rm -f ${TMPDIR}/keylist.$$
