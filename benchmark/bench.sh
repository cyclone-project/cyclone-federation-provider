#!/bin/sh
set -e

usage() {
	echo "bench.sh [benchmark script] [benchmark target] [worker1] [worker2] [replicas] [output directory]"
}

bench="$1"
target="$2"
worker1="$3"
worker2="$4"
replicas="$5"
output="$6"
pause=30
datestamp=`date "+%Y-%m-%dT%H_%M_%S"`
jmeter="/home/omer/workspace/cyclone/cyclone-benchmark/apache-jmeter-3.3/bin/jmeter"

if [ -z "$bench" ] || [ -z "$target" ] || [ -z "$worker1" ] || [ -z "$worker2" ] || [ -z "$replicas" ] || [ -z "$output" ]; then
	usage
	exit 1
fi

echo "Running Benchmark Script $bench"
echo "with target $target"
echo "specified replicas: $replicas"
echo "Saving results to $output"

mkdir -p "$output/$datestamp"

echo "Benchmark Script $bench with target $target and 10 users"
$jmeter -n -t $bench \
	-Jusers=10 \
	-Jcycloneserver=$target \
	-Jpmout="$output/$datestamp/pm${replicas}_10" \
	-Jworker1="$worker1" \
	-Jworker2="$worker2" \
	-l "$output/$datestamp/log${replicas}_10" \
	-e -o "$output/$datestamp/rep${replicas}_10"
sleep $pause

echo "Benchmark Script $bench with target $target and 25 users"
$jmeter -n -t $bench \
	-Jusers=25 \
	-Jcycloneserver=$target \
	-Jpmout="$output/$datestamp/pm${replicas}_25" \
	-Jworker1="$worker1" \
	-Jworker2="$worker2" \
	-l "$output/$datestamp/log${replicas}_25" \
	-e -o "$output/$datestamp/rep${replicas}_25"
sleep $pause

echo "Benchmark Script $bench with target $target and 100 users"
$jmeter -n -t $bench \
	-Jusers=100 \
	-Jcycloneserver=$target \
	-Jpmout="$output/$datestamp/pm${replicas}_100" \
	-Jworker1="$worker1" \
	-Jworker2="$worker2" \
	-l "$output/$datestamp/log${replicas}_100" \
	-e -o "$output/$datestamp/rep${replicas}_100"
sleep $pause

echo "Benchmark Script $bench with target $target and 500 users"
$jmeter -n -t $bench \
	-Jusers=500 \
	-Jcycloneserver=$target \
	-Jpmout="$output/$datestamp/pm${replicas}_500" \
	-Jworker1="$worker1" \
	-Jworker2="$worker2" \
	-l "$output/$datestamp/log${replicas}_500" \
	-e -o "$output/$datestamp/rep${replicas}_500"
sleep $pause

#echo "Benchmark Script $bench with target $target and 1000 users"
#$jmeter -n -t $bench \
#	-Jusers=1000 \
#	-Jcycloneserver=$target \
#	-Jpmout="$output/$datestamp/pm${replicas}_1000" \
#	-Jworker1="$worker1" \
#	-Jworker2="$worker2" \
#	-l "$output/$datestamp/log${replicas}_1000" \
#	-e -o "$output/$datestamp/rep${replicas}_1000"

echo "done"

