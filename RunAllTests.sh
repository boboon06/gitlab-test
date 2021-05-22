#! /bin/sh

hasTestFailed=false
for i in tests/*.in;
do
	testName=$(basename "$i" .in)
	echo "Testing $testName.in..."
	docker run --mount type=bind,src=$(pwd)/tests,dst=/etc/tests $CI_REGISTRY_IMAGE/simulator:$CI_COMMIT_REF_SLUG "/etc/tests/$testName.in"
	testResult=$?
	echo "Testing $testName.in returned exit code $testResult"
	if [ $testResult -ne 0 ]; then
		hasTestFailed=true
	fi
	
	if [ ! -f "$1.in.result" ]; then
		echo "No result file for $testName.in found. Was looking for \"$1.in.result\""
		hasTestFailed=true
	fi
done

if $hasTestFailed; then
	exit 1
	fi