file_path=/etc/prometheus/prometheus.yml
file_old_stat="`stat ${file_path}|grep Modify`"
while [[ true ]]; do
  sleep 5s
  now=$(date +%c)
  if [ -f "$file_path" ]; then
     file_new_stat="`stat ${file_path}|grep Modify`"
     if [[ `echo ${file_old_stat}` == `echo ${file_new_stat}` ]]; then
        echo "${now} : In 5s ,${file_path} does not change"
     else
        echo "${now} : file change"
        echo "${now} : new file --> ${file_new_stat}"
        echo "${now} : old file --> ${file_old_stat}"
        file_old_stat=${file_new_stat}
        wget --post-data="" http://127.0.0.1:9090/-/reload
     fi
  else
    echo "${now} : file no exit "
  fi
done
