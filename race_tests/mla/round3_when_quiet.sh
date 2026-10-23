#!/bin/bash
# Wait for the GPU to go quiet (slice tenant finished), then run the round-3
# A/B measurements.  Writes round3_results.json / round3.log.
source /data/tilelang-metax/race_tests/nsa/env.sh
cd /data/tilelang-metax/race_tests/mla

quiet_streak=0
for i in $(seq 1 240); do
  U=$(mx-smi 2>/dev/null | grep -oP '^\|\s+\d+% ' | head -1 | tr -dc '0-9')
  M=$(mx-smi 2>/dev/null | grep -oP '\d+/65536' | head -1 | tr -dc '0-9/')
  U=${U:-100}; M=${M:-99999/65536}
  echo "$(date +%H:%M:%S) poll=$i util=${U}% mem=${M}MiB quiet_streak=$quiet_streak"
  if [ "$U" -le 2 ] && [ "$M" -le 1200 ]; then
    quiet_streak=$((quiet_streak+1))
  else
    quiet_streak=0
  fi
  if [ "$quiet_streak" -ge 3 ]; then
    echo "$(date +%H:%M:%S) GPU QUIET for 3 consecutive polls -- starting round-3 A/B"
    break
  fi
  sleep 60
done

if [ "$quiet_streak" -lt 3 ]; then
  echo "GPU never went quiet within the polling window -- no measurements taken."
  exit 0
fi

python sweep.py --modules mla,mla2 --cases 1,3,6,12,17,22,27,31 --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax' --output round3_base.json
python sweep.py --modules mla,mla2 --cases 1,3,6,12,17,22,27,31 --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True' --output round3_maxless.json
python sweep.py --modules mla,mla2 --cases 1,3,6,12,17,22,27,31 --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,hoist_mask=True,clear_acc=True' --output round3_hoist.json
python sweep.py --modules mla,mla2 --cases 1,3,6,12,17,22,27,31 --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True,hoist_mask=True,clear_acc=True' --output round3_all3.json
echo "$(date +%H:%M:%S) round-3 A/B complete; see round3_*.json"
