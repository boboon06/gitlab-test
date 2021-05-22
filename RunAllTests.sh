#! /bin/sh

hasTestFailed=false
for i in tests/*.in;
do
	docker run --mount type=bind,src=tests,dst=/etc/tests $CI_REGISTRY_IMAGE/simulator:$CI_COMMIT_REF_SLUG /etc/tests/$i.in
	testResult = $?
	echo "Testing $i.in returned exit code $testResult"
	if (testResult != 0)
		hasTestFailed = true
done

if (hasTestFailed)
	exit 1