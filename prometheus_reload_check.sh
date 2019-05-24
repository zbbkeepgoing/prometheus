file_path=/etc/prometheus/prometheus.yml
file_old_stat="`stat ${file_path}|grep Modify`"
while [[ true ]]; do
  sleep 2s
  if [ -f "$file_path" ]; then
     file_new_stat="`stat ${file_path}|grep Modify`"
     if [[ `echo ${file_old_stat}` == `echo ${file_new_stat}` ]]; then
        echo "### In 5s ,${file_path} does not change ###"
     else
        echo ${file_new_stat}
        echo ${file_old_stat}
        file_old_stat=${file_new_stat}
        echo "file change"
        curl -XPOST http://127.0.0.1:9090/-/reload
     fi
  else
    echo "file no exit "
  fi
done
