#!/bin/bash

./compile && ./run > test_out.txt
echo $(date) >> test_out.txt
if [ $? -eq 0 ]; then
  cat test_results.txt | grep -v "clang++" | cut -d' ' -f16- > test_out1.txt
  cat test_out.txt | grep -v "clang++" | cut -d' ' -f16- > test_out2.txt
#  cat test_results.txt | grep -v "clang++" > test_out1.txt
#  cat test_out.txt | grep -v "clang++" > test_out2.txt
  colordiff -q test_out1.txt test_out2.txt | grep "differ"
  if [ $? -eq 0 ]; then
    colordiff test_out1.txt test_out2.txt | less -R
  else
    echo -e "\033[0;32m"
    echo "Passed"
    echo -e "\033[0;30m"
  fi
fi
