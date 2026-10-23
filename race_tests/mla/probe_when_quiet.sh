#!/bin/bash
# Wait for the GPU to go quiet (slice tenant finished), then run the
# transposed-PV probe round-robin.  Writes probe_pv_quiet.log.
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
    echo "$(date +%H:%M:%S) GPU QUIET for 3 consecutive polls -- running probe"
    break
  fi
  sleep 60
done

if [ "$quiet_streak" -lt 3 ]; then
  echo "GPU never went quiet within the polling window -- no measurements."
  exit 0
fi

python probe_pv_transpose.py 2>&1 | grep -v "INFO\|WARNING\|Loading"
echo "$(date +%H:%M:%S) probe complete; starting real-kernel sweep matrix"

CASES=1,3,6,12,17,22,27,31
python sweep.py --modules mla,mla2 --cases $CASES --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True' --output quiet_base.json
python sweep.py --modules mla,mla2 --cases $CASES --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True,pv=man' --output quiet_pvman.json
python sweep.py --modules mla,mla2 --cases $CASES --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True,pv=tr' --output quiet_pvtr.json
python sweep.py --modules mla,mla2 --cases $CASES --agg min --repeat 50 \
    --cfg 'kv_path=shared,softmax=nmax,maxless_merge=True,atomic_merge=True' --output quiet_atomic.json
echo "$(date +%H:%M:%S) sweep matrix complete"
