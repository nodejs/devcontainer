if [[ -z "${ORIGIN_URL}" ]]
then
    echo "ORIGIN_URL is not set"
else
  git remote set-url origin ${ORIGIN_URL}
fi