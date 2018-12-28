#!/usr/bin/env fish

# The purpose of this script is to create and destroy test environments, 
# and test the operation of the fishshell installation process without 
# being destructive of my personal home directory

function fixture -d "run all the tests"
    set test_path (setup)
    run_tests $test_path
    teardown $test_path
end

function run_tests -a test_path -d "description"
    
end

function setup -d "set everything up"
    set path (create_test_folder)
    echo $path
end

function teardown -a path -d "clean up"
    remove_home_folder_structure $path
end

function create_test_folder -d "creates a temporary directory for testing"
    set path ( get_test_folder (get_base_path) )
    mkdir -p $path
    setup_home_folder_structure $path
    echo $path
end

function get_base_path -d "find a place for the test directory to go"
    echo "/tmp/fishdots_test"
end

function get_test_folder -a base_path -d "generates a name for a test folder and creates it"
    set ts (date +%s)
    set p "$base_path/$ts"
    echo $p
end

function setup_home_folder_structure -a path -d "places sample home folder files and folders into the test folder"
    tar -xzvf test_home_folder.tgz -C $path
end

function remove_home_folder_structure -a path -d "description"
    rm -rf $path
end

function is_file_under_control -a file_name -d "determines whether a file has been placed under indirection control"
    
end

function get_gen_of_file -a file_name -d "traces the location of a file and confirms where, within the generations system, it is located"
    
end

