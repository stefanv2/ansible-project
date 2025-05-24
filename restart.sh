for c in ubuntu01 ubuntu02 ubuntu03 ubuntu04 ubuntu05; do
  echo "➡️ Start ssh in $c"
  docker exec -it "$c" service ssh restart
done
