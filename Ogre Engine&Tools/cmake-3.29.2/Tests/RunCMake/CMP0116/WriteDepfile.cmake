file(TOUCH "${OUTFILE}")
file(TOUCH "${STAMPFILE}")
file(WRITE "${DEPFILE}" "${DEPDIR}${OUTFILE}: ${DEPDIR}${INFILE}\n")
