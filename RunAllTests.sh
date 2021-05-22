#! /bin/sh

hasTestFailed=false
for i in tests/*.in;
do
	testName=$(basename "$i" .in)
	echo "Testing $testName.in..."
	docker run --mount type=bind,src=$(pwd)/tests,dst=/etc/tests -a=['stdout', 'stderr'] --rm $CI_REGISTRY_IMAGE/simulator:$CI_COMMIT_REF_SLUG "/etc/tests/$testName.in"
	testResult=$?
	echo "Testing $testName.in returned exit code $testResult"
	if [ $testResult -ne 0 ]; then
		hasTestFailed=true
	fi
done

ls tests -al

if $hasTestFailed; then
	exit 1
	fi