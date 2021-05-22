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
	
	if [ ! -f "$i.result" ]; then
		echo "\e[31mNo result file for $testName.in found. Was looking for \"$i.result\"\e[0m"
		hasTestFailed=true
	else
		if cmp --silent -- "$i.result" "tests/$testName.gold"; then
			echo "\e[32mThe test results match the expected results.\e[0m"
		else
			echo "\e[31mThe test results do not match the expected results.\e[0m"
		fi
	fi
done

if $hasTestFailed; then
	exit 1
	fi