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
		echo "[Failure] The simulator returned a non-zero exit code."
		hasTestFailed=true
	fi
	
	if [ ! -f "$i.result" ]; then
		echo "[Failure] No result file for $testName.in found. Was looking for \"$i.result\""
		hasTestFailed=true
	else
		if cmp -s -- "$i.result" "tests/$testName.gold"; then
			echo "[Pass] The test results match the expected results."
		else
			echo "[Failure] The test results do not match the expected results."
			cmp -- "$i.result" "tests/$testName.gold"
			hasTestFailed=true
		fi
	fi
done

if $hasTestFailed; then
	exit 1
	fi