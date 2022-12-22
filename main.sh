#!/bin/bash
echo "Starting process"
echo

if [ ! -f "build" ]; then
    echo "------------------------"
    echo "Generating Makefile" && mkdir build
    echo "------------------------"
    echo
fi

cd build

# Check if Makefile exists. If not then create Makefile.
if [ ! -f "Makefile" ]; then
    echo "Generating Makefile" && cmake ..
    echo
fi

echo "------------------------"
echo "Building project"
echo "------------------------"
echo

make

case $1 in
  memcheck)
    echo "------------------------"
    echo "Running memory check"
    echo "------------------------"
    echo
    valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --log-file=./valgrind-out.txt ./membot
    ;;

  *)
    echo "------------------------"
    echo "Starting project"
    echo "------------------------"
    echo

    ./membot
    ;;
esac

echo "Process complete!"