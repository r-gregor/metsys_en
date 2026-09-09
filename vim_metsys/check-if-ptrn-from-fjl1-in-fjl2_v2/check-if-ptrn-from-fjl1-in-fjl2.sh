#! /usr/bin/env bash
# fname: check-if-ptrn-from-fjl1-in-fjl2.sh
# 20260908 v1
# 20260908 v2 put compare logic into compare_patterns() and compare_patterns_reverse() functions
#             and do the comparison in both ways: FJL1 to FJL and FJL2 to FJL1
# last 20260908
# ---

usage() {
	printf "Usage: check-if-ptrn-from-fjl1-in-fjl2.sh <fname1> <fname2>\n\n"
}

compare_patterns() {
	while read PTRN1; do
		while read PTRN2; do
			found=0
			# if [[ $PTRN1 =~ $PTRN2 ]]; then
			if [[ "${PTRN1}" == "${PTRN2}" ]]; then
				found=1
				break
			else
				continue
			fi
		done < "${FJL2}"
		if [ $found -eq 0 ]; then
			# echo "$PTRN1 NOT found!"
			(( mismaches_found++ ))
			printf "[INFO] %s from '%s' NOT found in '%s'\n" "${PTRN1}" "${FJL1}" "${FJL2}"
		fi
	done < "${FJL1}"
}

compare_patterns_reverse() {
	while read PTRN1; do
		while read PTRN2; do
			found=0
			# if [[ $PTRN1 =~ $PTRN2 ]]; then
			if [[ "${PTRN1}" == "${PTRN2}" ]]; then
				found=1
				break
			else
				continue
			fi
		done < "${FJL1}"
		if [ $found -eq 0 ]; then
			# echo "$PTRN1 NOT found!"
			(( mismaches_found++ ))
			printf "[INFO] %s from '%s' NOT found in '%s'\n" "${PTRN1}" "${FJL2}" "${FJL1}"
		fi
	done < "${FJL2}"
}

# MAIN
mismaches_found=0

if [  $# -ne 2 ]; then
	usage
	exit 1
else
	FJL1="${1}"
	FJL2="${2}"
fi

if [ ! -f "${FJL1}" ]; then
	printf "[ERROR] no such file: %s\n\n" "${FJL1}"
	exit 1
fi


if [ ! -f "${FJL2}" ]; then
	printf "[ERROR] no such file: %s\n\n" "${FJL2}"
	exit 1
fi


compare_patterns
printf -- "---\n"
compare_patterns_reverse

if [ "${mismaches_found}" -eq 0 ]; then
	printf "[INFO] ALL PATTERNS MATCH!\n\n"
else
	printf "\n"
fi

