# autoreftests

Testcases for the ER-Force autoref.

In order to run these tests, use the following steps:
- start in the autoref repository, it must be up to date
- cd src/framework
- mkdir build
- cd build
- cmake ..
- make replay-cli
- python3 run_replay_tests.py path/to/this/repository/autoreftests ../../../autoref/init.lua

Every testcase is represented by one log file.
These log files are in the ER-Force log format and can be opened by Ra/Logplayer found in the ER-Force framework.
