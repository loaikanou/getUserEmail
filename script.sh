#!/bin/bash
echo "-------- START READING FILE --------"
path=$(pwd)
workDir="repositories"
developerID=0
echo "Enter File: "
read gitFile
while read repository; do
	# echo $repository
	arr=(` echo $repository | tr '/' ' ' `)
	project="${arr[3]}"
	projectPath="${path}/${workDir}/${project}"

	# Strat Clone Projects from Github
	echo "---# Start Cloning project ${project} #---"
	git clone $repository ${workDir}/${project}

	# git log file
	cd ${workDir}/${project}
	git log > ../${project}_log.txt
	cd ${path}
	# remove project repository
	rm -rf $projectPath

	# find Author and Email
	while read line; do
		if [[ $line = "Author: "* ]]; then

			# Remove Duplicate Author
			if ! [[ $(grep "$line" "data.txt" ) ]]; then
				echo $line >> data.txt
			fi			
			
		fi
	done < ${workDir}/${project}_log.txt

done < $gitFile
echo "----## Done ##----"
